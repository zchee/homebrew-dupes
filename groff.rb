require 'formula'

class Groff < Formula
  homepage 'http://www.gnu.org/software/groff/'
  url 'http://ftpmirror.gnu.org/groff/groff-1.22.2.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/groff/groff-1.22.2.tar.gz'
  sha1 '37223941e25bb504bf54631daaabb01b147dc1d3'

  def install
    system "./configure", "--prefix=#{prefix}", "--without-x"
    system "make" # Separate steps required
    system "make install"
  end
end
