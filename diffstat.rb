require 'formula'

class Diffstat < Formula
  homepage 'http://invisible-island.net/diffstat/'
  url 'http://invisible-island.net/datafiles/release/diffstat.tar.gz'
  version '1.56'
  sha1 '034c3a72e5d06f5433cdba8c1b6d25146dd699d1'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  test do
    system "#{bin}/diffstat", "--version"
  end
end
