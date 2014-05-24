require 'formula'

class TclTk < Formula
  homepage 'http://www.tcl.tk/'
  url 'https://downloads.sourceforge.net/project/tcl/Tcl/8.6.1/tcl8.6.1-src.tar.gz'
  version '8.6.1'
  sha1 '5c83d44152cc0496cc0847a2495f659502a30e40'

  keg_only "Tk installs some X11 headers and OS X provides an (older) Tcl/Tk."

  option 'enable-threads', 'Build with multithreading support'
  option 'without-tk', "Don't build the Tk (window toolkit)"
  option 'with-x11', 'Build X11-based Tk instead of Aqua-based Tk'

  depends_on :x11 => :optional

  resource 'tk' do
    url 'http://downloads.sourceforge.net/project/tcl/Tcl/8.6.1/tk8.6.1-src.tar.gz'
    version '8.6.1'
    sha1 'ecfcc20833c04d6890b14a7920a04d16f2123a51'
  end

  # https://github.com/Homebrew/homebrew-dupes/issues/286
  # If built with gcc-4.2, tk will still run.
  fails_with :clang do
    build 503
    cause "Objective C garbage collection is no longer supported in clang 5.1"
  end if build.with? 'tk'

  # sqlite won't compile on Tiger due to missing function;
  # patch submitted upstream: http://thread.gmane.org/gmane.comp.db.sqlite.general/83257
  patch :DATA if MacOS.version < :leopard

  def install
    args = ["--prefix=#{prefix}", "--mandir=#{man}"]
    args << "--enable-threads" if build.include? "enable-threads"
    args << "--enable-64bit" if MacOS.prefer_64_bit?

    cd 'unix' do
      system "./configure", *args
      system "make"
      system "make install"
      system "make install-private-headers"
      ln_s bin+'tclsh8.6', bin+'tclsh'
    end

    if build.with? 'tk'
      ENV.prepend_path 'PATH', bin # so that tk finds our new tclsh

      resource('tk').stage do
        # Upstream fix for rendering on 10.9; should be in next release
        # https://core.tcl.tk/tk/info/5a5abf71f9
        # This is an inreplace and not a patch because resources don't
        # support patches. Luckily it's a one-line fix.
        inreplace 'macosx/tkMacOSXDraw.c',
          '[[dcPtr->view window] enableFlushWindow];',
          "[[dcPtr->view window] setViewsNeedDisplay:YES];\n[[dcPtr->view window] enableFlushWindow];"
        args = ["--prefix=#{prefix}",  # this is the prefix from TclTk
                "--mandir=#{man}",
                "--with-tcl=#{lib}"]
        args << "--enable-threads" if build.include? "enable-threads"
        args << "--enable-64bit" if MacOS.prefer_64_bit?

        if build.with? "x11"
          args << "--with-x"
        else
          args << "--enable-aqua=yes"
          args << "--without-x"
        end

        cd 'unix' do
          system "./configure", *args
          system "make", "TK_LIBRARY=#{lib}"
          # system "make test"  # for maintainers
          system "make install"
          system "make install-private-headers"
          ln_s bin+'wish8.6', bin+'wish'
        end
      end
    end
  end
end

__END__
diff --git a/pkgs/sqlite3.7.15.1/generic/sqlite3.c b/pkgs/sqlite3.7.15.1/generic/sqlite3.c
index e877d77..dfde114 100644
--- a/pkgs/sqlite3.7.15.1/generic/sqlite3.c
+++ b/pkgs/sqlite3.7.15.1/generic/sqlite3.c
@@ -15497,6 +15497,7 @@ SQLITE_PRIVATE void sqlite3MemSetDefault(void){
 #include <sys/sysctl.h>
 #include <malloc/malloc.h>
 #include <libkern/OSAtomic.h>
+
 static malloc_zone_t* _sqliteZone_;
 #define SQLITE_MALLOC(x) malloc_zone_malloc(_sqliteZone_, (x))
 #define SQLITE_FREE(x) malloc_zone_free(_sqliteZone_, (x));
@@ -15504,6 +15505,29 @@ static malloc_zone_t* _sqliteZone_;
 #define SQLITE_MALLOCSIZE(x) \
         (_sqliteZone_ ? _sqliteZone_->size(_sqliteZone_,x) : malloc_size(x))
 
+/*
+** If compiling for Mac OS X 10.4, the OSAtomicCompareAndSwapPtrBarrier
+** function will not be available, but individual 32-bit and 64-bit
+** versions will.
+*/
+
+#ifdef __MAC_OS_X_MIN_REQUIRED
+# include <AvailabilityMacros.h>
+#elif defined(__IPHONE_OS_MIN_REQUIRED)
+# include <Availability.h>
+#endif
+
+typedef int fc_atomic_int_t;
+#if (MAC_OS_X_VERSION_MIN_REQUIRED > MAC_OS_X_VERSION_10_4 || __IPHONE_VERSION_MIN_REQUIRED >= 20100)
+# define fc_atomic_ptr_cmpexch(O,N,P) OSAtomicCompareAndSwapPtrBarrier ((void *) (O), (void *) (N), (void **) (P))
+#else
+# if __ppc64__ || __x86_64__
+#  define fc_atomic_ptr_cmpexch(O,N,P) OSAtomicCompareAndSwap64Barrier ((int64_t) (O), (int64_t) (N), (int64_t*) (P))
+# else
+#  define fc_atomic_ptr_cmpexch(O,N,P) OSAtomicCompareAndSwap32Barrier ((int32_t) (O), (int32_t) (N), (int32_t*) (P))
+# endif
+#endif
+
 #else /* if not __APPLE__ */
 
 /*
@@ -15664,7 +15688,7 @@ static int sqlite3MemInit(void *NotUsed){
     malloc_zone_t* newzone = malloc_create_zone(4096, 0);
     malloc_set_zone_name(newzone, "Sqlite_Heap");
     do{
-      success = OSAtomicCompareAndSwapPtrBarrier(NULL, newzone, 
+      success = fc_atomic_ptr_cmpexch(NULL, newzone, 
                                  (void * volatile *)&_sqliteZone_);
     }while(!_sqliteZone_);
     if( !success ){
