require 'formula'

class Tcl < Formula
  homepage 'http://www.tcl.tk/'
  url 'http://sourceforge.net/projects/tcl/files/Tcl/8.5.13/tcl8.5.13-src.tar.gz'
  version '8.5.13'
  sha1 '65b677dc699426233b926edfa9e304d456da7cad'

  option 'enable-threads', 'Build with multithreading support'

  def install
    args = ["--prefix=#{prefix}", "--mandir=#{man}"]
    args << "--enable-threads" if build.include? "enable-threads"
    args << "--enable-64bit" if MacOS.prefer_64_bit?

    cd 'unix' do
      # required because the tcl library is in the Cellar far away from other
      # libraries. Communication with tk will get confused and look for the
      # tk-scripts inside tcl-prefix. Upstream inquiry:
      # http://sourceforge.net/mailarchive/forum.php?thread_name=CAEoiczcr%2ByOu8XYy8Erfb%3DxOUb8mriDewKZw7Sse3mtoG9AEJg%40mail.gmail.com&forum_name=tcl-core
      inreplace 'Makefile.in' do |s|
        s.change_make_var! "TCL_LIBRARY", "#{HOMEBREW_PREFIX}/lib/tcl$(VERSION)"
      end

      system "./configure", *args
      system "make"
      system "make test"
      system "make install"
      system "make install-private-headers"
    end
  end
end
