require 'formula'

class Unzip < Formula
  homepage 'http://www.info-zip.org/pub/infozip/UnZip.html'
  url 'http://downloads.sourceforge.net/project/infozip/UnZip%206.x%20%28latest%29/UnZip%206.0/unzip60.tar.gz'
  version '6.0'
  sha1 'abf7de8a4018a983590ed6f5cbd990d4740f8a22'

  keg_only :provided_by_osx

  def install
    system "make", "-f", "unix/Makefile", "macosx"
    system "make", "prefix=#{prefix}", "MANDIR=#{man}", "install"
  end

  test do
    system "#{bin}/unzip", "--help"
  end
end
