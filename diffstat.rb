require 'formula'

class Diffstat < Formula
  homepage 'http://invisible-island.net/diffstat/'
  url 'http://invisible-island.net/datafiles/release/diffstat.tar.gz'
  version '1.57'
  sha1 'c6d9247b8b32eeab5d866686f91a8fbdde3e340f'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  test do
    system "#{bin}/diffstat", "--version"
  end
end
