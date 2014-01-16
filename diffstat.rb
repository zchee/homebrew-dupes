require 'formula'

class Diffstat < Formula
  homepage 'http://invisible-island.net/diffstat/'
  url 'http://invisible-island.net/datafiles/release/diffstat.tar.gz'
  version '1.58'
  sha1 '7a67ecb996ea65480bd0b9db33d8ed458e5f2a24'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  test do
    system "#{bin}/diffstat", "--version"
  end
end
