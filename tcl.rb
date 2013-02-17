require 'formula'

class Tcl < Formula
  homepage 'http://www.tcl.tk/'
  url 'http://sourceforge.net/projects/tcl/files/Tcl/8.6.0/tcl8.6.0-src.tar.gz'
  version '8.6.0'
  sha1 'fc57fc08ab113740a702bb67d4f350f8ec85ef58'

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
      system "make install"
      system "make install-private-headers"
    end
  end
end
