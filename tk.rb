require 'formula'

class Tk < Formula
  homepage 'http://www.tcl.tk/'
  url 'http://sourceforge.net/projects/tcl/files/Tcl/8.6.0/tk8.6.0-src.tar.gz'
  version '8.6.0'
  sha1 'c42e160285e2d26eae8c2a1e6c6f86db4fa7663b'

  # must use a Homebrew-built Tcl since versions must match
  depends_on 'tcl'
  depends_on :x11

  option 'enable-threads', 'Build with multithreading support'
  option 'enable-aqua', 'Build with Aqua support'

  def install
    args = ["--prefix=#{prefix}",
            "--mandir=#{man}",
            "--with-tcl=#{HOMEBREW_PREFIX}/lib"]
    args << "--enable-threads" if build.include? "enable-threads"
    args << "--enable-aqua" if build.include? "enable-aqua"
    args << "--enable-64bit" if MacOS.prefer_64_bit?

    cd 'unix' do
      # so we can find the necessary Tcl headers
      ENV.append 'CFLAGS', "-I#{HOMEBREW_PREFIX}/include"

      system "./configure", *args
      system "make"
      system "make install"

      ln_s bin+'wish8.6', bin+'wish'
    end

    # Awww tk, don't install (outdated) X11 headers!
    # (See http://trac.macports.org/ticket/8730)
    if build.include? "enable-aqua"
      rm_rf(include/'X11')
    end
  end
end
