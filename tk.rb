require 'formula'

class Tk < Formula
  homepage 'http://www.tcl.tk/'
  url 'http://sourceforge.net/projects/tcl/files/Tcl/8.6.0/tk8.6.0-src.tar.gz'
  version '8.6.0'
  sha1 'c42e160285e2d26eae8c2a1e6c6f86db4fa7663b'

  option 'enable-threads', 'Build with multithreading support'

  keg_only "Tk installs some X11 headers and OS X provides an (older)."

  # must use a Homebrew-built Tcl since versions must match
  depends_on 'tcl'
  depends_on :x11 => :optional

  def install
    args = ["--prefix=#{prefix}",
            "--mandir=#{man}",
            "--with-tcl=#{Formula.factory('tcl').opt_prefix}/lib"]
    args << "--enable-threads" if build.include? "enable-threads"
    args << "--enable-64bit" if MacOS.prefer_64_bit?

    if build.with? "x11"
      args << "--with-x"
    else
      args << "--enable-aqua"
      args << "--without-x"
    end

    cd 'unix' do
      system "./configure", *args
      system "make", "LIB_RUNTIME_DIR=#{lib}"
      # system "make test"  # for maintainers
      system "make install"
      system "make install-private-headers"

      ln_s bin+'wish8.6', bin+'wish'
    end

  end
end
