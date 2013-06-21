require 'formula'

# Based on:
# Apple Open Source: http://www.opensource.apple.com/source/cvs/cvs-45/
# MacPorts: https://trac.macports.org/browser/trunk/dports/devel/cvs/Portfile
# Creating a useful testcase: http://mrsrl.stanford.edu/~brian/cvstutorial/

class Cvs < Formula
  homepage 'http://cvs.nongnu.org/'
  url 'http://ftp.gnu.org/non-gnu/cvs/source/feature/1.12.13/cvs-1.12.13.tar.bz2'
  sha1 '93a8dacc6ff0e723a130835713235863f1f5ada9'

  def patches
    { :p0 =>
      [ 'http://www.opensource.apple.com/source/cvs/cvs-45/patches/PR5178707.diff?txt',
        'http://www.opensource.apple.com/source/cvs/cvs-45/patches/ea.diff?txt',
        'http://www.opensource.apple.com/source/cvs/cvs-45/patches/endian.diff?txt',
        'http://www.opensource.apple.com/source/cvs/cvs-45/patches/fixtest-client-20.diff?txt',
        'http://www.opensource.apple.com/source/cvs/cvs-45/patches/fixtest-recase.diff?txt',
        'http://www.opensource.apple.com/source/cvs/cvs-45/patches/i18n.diff?txt',
        'http://www.opensource.apple.com/source/cvs/cvs-45/patches/initgroups.diff?txt',
        'http://www.opensource.apple.com/source/cvs/cvs-45/patches/nopic.diff?txt',
        'http://www.opensource.apple.com/source/cvs/cvs-45/patches/remove-info.diff?txt',
        'http://www.opensource.apple.com/source/cvs/cvs-45/patches/remove-libcrypto.diff?txt',
        'http://www.opensource.apple.com/source/cvs/cvs-45/patches/tag.diff?txt',
        'http://www.opensource.apple.com/source/cvs/cvs-45/patches/zlib.diff?txt'
      ]
    }
  end

  def install
    # Much weirdness ensues if you try to parallelize builds. Especially during installation.
    ENV.j1

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--infodir=#{prefix}/share/info",
                          "--mandir=#{prefix}/share/man",
                          "--with-gssapi",
                          "-enable-pam",
                          "--enable-encryption",
                          "--with-external-zlib",
                          "--enable-case-sensitivity",
                          "--with-editor=vim",
                          "ac_cv_func_working_mktime=no"

    # Deal with config.h, since it's generated AFTER ./configure, so we can't prepatch it
    File.open('config.h.ed', 'w') {|f| f.write(DATA.read.to_s)}
    system "cat config.h.ed | ed - config.h"

    system "make", "install"
  end

  test do
    system "mkdir", "cvsroot"
    system "mkdir", "cvsexample"

    cvsexample = %x[echo ${PWD}/cvsexample].chomp
    cvsroot = %x[echo ${PWD}/cvsroot].chomp

    system "#{bin}/cvs", "-d", cvsroot, "init"
    system "cd", cvsexample, ";", "CVSROOT=#{cvsroot}", "#{bin}/cvs", "import", "-m ", "'dir structure'", "cvsexample", "homebrew", "start"
  end
end

__END__
/SIZEOF_LONG/c
#ifdef __LP64__
#define SIZEOF_LONG 8
#else /* !__LP64__ */
#define SIZEOF_LONG 4
#endif /* __LP64__ */
.
/SIZEOF_PTRDIFF_T/c
#ifdef __LP64__
#define SIZEOF_PTRDIFF_T 8
#else /* !__LP64__ */
#define SIZEOF_PTRDIFF_T 4
#endif /* __LP64__ */
.
/SIZEOF_SIZE_T/c
#ifdef __LP64__
#define SIZEOF_SIZE_T 8
#else /* !__LP64__ */
#define SIZEOF_SIZE_T 4
#endif /* __LP64__ */
.
/UNIQUE_INT_TYPE_LONG/c
#ifdef __LP64__
#define UNIQUE_INT_TYPE_LONG 1
#else /* !__LP64__ */
/* #undef UNIQUE_INT_TYPE_LONG */
#endif /* __LP64__ */
.
/UNIQUE_INT_TYPE_LONG_LONG/c
#ifdef __LP64__
/* #undef UNIQUE_INT_TYPE_LONG_LONG */
#else /* !__LP64__ */
#define UNIQUE_INT_TYPE_LONG_LONG 1
#endif /* __LP64__ */
.
w