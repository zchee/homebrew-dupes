class Diffutils < Formula
  homepage 'https://www.gnu.org/s/diffutils/'
  url 'http://ftpmirror.gnu.org/diffutils/diffutils-3.3.tar.xz'
  mirror 'https://ftp.gnu.org/gnu/diffutils/diffutils-3.3.tar.xz'
  sha1 '6463cce7d3eb73489996baefd0e4425928ecd61e'

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
  end
end
