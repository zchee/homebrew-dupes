require 'formula'

class Diffstat < Formula
  homepage 'http://invisible-island.net/diffstat/'
  url 'ftp://invisible-island.net/diffstat/diffstat-1.58.tgz'
  sha256 'fad5135199c3b9aea132c5d45874248f4ce0ff35f61abb8d03c3b90258713793'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  test do
    system "#{bin}/diffstat", "--version"
  end
end
