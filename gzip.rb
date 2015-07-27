class Gzip < Formula
  desc "Popular GNU data compression program"
  homepage "https://www.gnu.org/software/gzip"
  url "http://ftpmirror.gnu.org/gzip/gzip-1.6.tar.gz"
  mirror "https://ftp.gnu.org/gnu/gzip/gzip-1.6.tar.gz"
  sha256 "97eb83b763d9e5ad35f351fe5517e6b71521d7aac7acf3e3cacdb6b1496d8f7e"

  bottle do
    cellar :any
    sha1 "80aff7ae695f8f7ed1b4a7a68566cd7e0fac6fa4" => :yosemite
    sha1 "d5d9891b8f1afea7c3d5288314f5bc3f6cb2a0af" => :mavericks
    sha1 "6c75eee3fb519f841177abae22bb4a3e30d237c9" => :mountain_lion
  end

  # Add support for --rsyncable option
  patch do
    url "https://cvs.pld-linux.org/cgi-bin/viewvc.cgi/cvs/packages/gzip/gzip-rsyncable.patch?revision=1.4&view=co"
    sha256 "c9024df8719d42b0b0f133f829865ccab2d5b58a0b5847a9425314d03fa8c9b6"
  end

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"foo").write "test"
    system "#{bin}/gzip", "foo"
    system "#{bin}/gzip", "-t", "foo.gz"
    assert_equal "test", shell_output("#{bin}/gunzip -c foo")
  end
end
