# "File" is a reserved class name
class FileFormula < Formula
  homepage "http://www.darwinsys.com/file/"
  url "ftp://ftp.astron.com/pub/file/file-5.23.tar.gz"
  mirror "https://fossies.org/linux/misc/file-5.23.tar.gz"
  sha256 "2c8ab3ff143e2cdfb5ecee381752f80a79e0b4cfe9ca4cc6e1c3e5ec15e6157c"

  head "https://github.com/file/file.git"

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/dupes"
    sha1 "82f413eec4ac2c36ea77028b5d0c615bdbb9886c" => :yosemite
    sha1 "58d0aba801d97081ee9c55d37026658186eaeee0" => :mavericks
    sha1 "695ef766c516ce3b122e0a8b3975bb122094a93a" => :mountain_lion
  end

  keg_only :provided_by_osx

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-fsect-man5"
    system "make", "install"
  end
end
