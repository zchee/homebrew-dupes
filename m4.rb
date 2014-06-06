require "formula"

class M4 < Formula
  homepage "https://www.gnu.org/software/m4"
  url "http://ftpmirror.gnu.org/m4/m4-1.4.17.tar.xz"
  mirror "https://ftp.gnu.org/gnu/m4/m4-1.4.17.tar.xz"
  sha1 "74ad71fa100ec8c13bc715082757eb9ab1e4bbb0"

  keg_only :provided_by_osx

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
