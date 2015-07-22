# "File" is a reserved class name
class FileFormula < Formula
  homepage "http://www.darwinsys.com/file/"
  url "ftp://ftp.astron.com/pub/file/file-5.23.tar.gz"
  mirror "https://fossies.org/linux/misc/file-5.23.tar.gz"
  sha256 "2c8ab3ff143e2cdfb5ecee381752f80a79e0b4cfe9ca4cc6e1c3e5ec15e6157c"

  head "https://github.com/file/file.git"

  bottle do
    sha256 "61994eeea1f7494b78cf881e59da8276b3b877377fd4e5cf95c70735f75324f3" => :yosemite
    sha256 "c765decba29c0d6cd521f2c3b6a59b9a8cb40570c1483d85809b76c97f836932" => :mavericks
    sha256 "d53e302ee2082cbd593d1da045723b3db0e171947c1a61c9112e66aced61e2c2" => :mountain_lion
  end

  keg_only :provided_by_osx

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-fsect-man5"
    system "make", "install"
  end
end
