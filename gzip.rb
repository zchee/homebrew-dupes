require 'formula'

class Gzip < Formula
  homepage 'http://www.gnu.org/software/gzip'
  url 'http://ftpmirror.gnu.org/gzip/gzip-1.5.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/gzip/gzip-1.5.tar.gz'
  sha1 '56a80da7b032107372d3f3343bed7c7af452a826'

  # Add support for --rsyncable option
  def patches
    "http://cvs.pld-linux.org/cgi-bin/viewvc.cgi/cvs/packages/gzip/gzip-rsyncable.patch?revision=1.4&view=co"
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "#{bin}/gzip", "-V"
  end
end
