require 'formula'

class Libarchive < Formula
  homepage 'http://www.libarchive.org'
  url 'http://www.libarchive.org/downloads/libarchive-3.1.1.tar.gz'
  sha1 'ee92567d68f2d7c2489c9c539834efa8a02106df'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end
end
