require 'formula'

class Gpatch < Formula
  homepage 'http://savannah.gnu.org/projects/patch/'
  url 'http://ftpmirror.gnu.org/patch/patch-2.7.1.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/patch/patch-2.7.1.tar.bz2'
  sha1 '1ebb78c850887c2191e58b2254786ef4595a4c5b'

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
  end
end
