require 'formula'

class Gzip < Formula
  homepage 'http://www.gnu.org/software/gzip'
  url 'http://ftpmirror.gnu.org/gzip/gzip-1.6.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/gzip/gzip-1.6.tar.gz'
  sha1 '7ec6403090b3eaeb53ef017223cb8034eebc1f49'

  # Add support for --rsyncable option
  patch do
    url "http://cvs.pld-linux.org/cgi-bin/viewvc.cgi/cvs/packages/gzip/gzip-rsyncable.patch?revision=1.4&view=co"
    sha1 "e59c60fcb8a70a8ef2884a624e439b0b6d9b5ace"
  end

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
  end

  test do
    system "#{bin}/gzip", "-V"
  end
end
