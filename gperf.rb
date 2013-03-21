require 'formula'

class Gperf < Formula
  homepage 'http://www.gnu.org/software/gperf'
  url 'http://ftpmirror.gnu.org/gperf/gperf-3.0.4.tar.gz'
  mirror 'http://ftp.gnu.org/pub/gnu/gperf/gperf-3.0.4.tar.gz'
  sha1 'e32d4aff8f0c730c9a56554377b2c6d82d0951b8'

  keg_only "Xcode (up to and including 4.3) provides (a rather old) Gperf."

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end

  test do
    system "#{bin}/gperf", "--version"
  end
end
