class Ncurses < Formula
  homepage 'https://www.gnu.org/s/ncurses/'
  url 'http://ftpmirror.gnu.org/ncurses/ncurses-5.9.tar.gz'
  mirror 'https://ftp.gnu.org/gnu/ncurses/ncurses-5.9.tar.gz'
  sha1 '3e042e5f2c7223bffdaac9646a533b8c758b65b5'

  bottle do
    root_url "https://homebrew.bintray.com/bottles-dupes"
    sha256 "1cbfe34e03d1005cd7ebf69250b3427b25969c4b7b3a81bd72e0a768d8f6a98b" => :yosemite
    sha256 "3f0b3398050ce5efb40adad245b868233f140f7365c7e4cc2a02ddf276066fe6" => :mavericks
    sha256 "66f88fb4d3930ebbd94b064e65dc22929c11bb49f215d8c84df7af733bd86e16" => :mountain_lion
  end

  keg_only :provided_by_osx

  option :universal

  # Fix building C++ bindings with clang
  patch :p0 do
    url "https://trac.macports.org/export/103963/trunk/dports/devel/ncurses/files/constructor_types.diff"
    sha1 "60f3e64c7793381307e2a3849df7ae282e46c36e"
  end

  # Stop using obsolete -no-cpp-precomp flag, which breaks FSF GCC
  # Reported upstream by email
  patch :DATA

  def install
    ENV.universal_binary if build.universal?

    ENV['PKG_CONFIG_LIBDIR'] = "#{lib}/pkgconfig"
    (lib/"pkgconfig").mkpath

    system "./configure", "--prefix=#{prefix}",
                          "--enable-pc-files",
                          "--enable-sigwinch",
                          "--enable-symlinks",
                          "--enable-widec",
                          "--mandir=#{man}",
                          "--with-manpage-format=normal",
                          "--with-shared"

    system "make"
    system "make install"
    make_libncurses_symlinks
  end

  def make_libncurses_symlinks
    major = version.to_s.split(".")[0]

    cd lib do
      %w{form menu ncurses panel}.each do |name|
        if OS.mac?
          ln_s "lib#{name}w.#{major}.dylib", "lib#{name}.dylib"
          ln_s "lib#{name}w.#{major}.dylib", "lib#{name}.#{major}.dylib"
        else
          ln_s "lib#{name}w.so.#{major}", "lib#{name}.so"
          ln_s "lib#{name}w.so.#{major}", "lib#{name}.so.#{major}"
        end
        ln_s "lib#{name}w.a", "lib#{name}.a"
        ln_s "lib#{name}w_g.a", "lib#{name}_g.a"
      end

      ln_s "libncurses++w.a", "libncurses++.a"
      ln_s "libncurses.a", "libcurses.a"
      if OS.mac?
        ln_s "libncurses.dylib", "libcurses.dylib"
      else
        ln_s "libncurses.so", "libcurses.so"
      end
    end

    cd bin do
      ln_s "ncursesw#{major}-config", "ncurses#{major}-config"
    end

    ln_s [
      "ncursesw/curses.h", "ncursesw/form.h", "ncursesw/ncurses.h",
      "ncursesw/term.h", "ncursesw/termcap.h"], include
  end
end

__END__
diff --git a/Ada95/configure b/Ada95/configure
index 4db6f1f..e82bb4b 100755
--- a/Ada95/configure
+++ b/Ada95/configure
@@ -7460,7 +7460,6 @@ CF_EOF
 		chmod +x mk_shared_lib.sh
 		;;
 	darwin*) #(vi
-		EXTRA_CFLAGS="-no-cpp-precomp"
 		CC_SHARED_OPTS="-dynamic"
 		MK_SHARED_LIB='${CC} ${CFLAGS} -dynamiclib -install_name ${libdir}/`basename $@` -compatibility_version ${ABI_VERSION} -current_version ${ABI_VERSION} -o $@'
 		test "$cf_cv_shlib_version" = auto && cf_cv_shlib_version=abi
diff --git a/configure b/configure
index 639b790..25d69b3 100755
--- a/configure
+++ b/configure
@@ -5584,7 +5584,6 @@ CF_EOF
 		chmod +x mk_shared_lib.sh
 		;;
 	darwin*) #(vi
-		EXTRA_CFLAGS="-no-cpp-precomp"
 		CC_SHARED_OPTS="-dynamic"
 		MK_SHARED_LIB='${CC} ${CFLAGS} -dynamiclib -install_name ${libdir}/`basename $@` -compatibility_version ${ABI_VERSION} -current_version ${ABI_VERSION} -o $@'
 		test "$cf_cv_shlib_version" = auto && cf_cv_shlib_version=abi

