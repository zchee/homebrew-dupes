class Gzip < Formula
  desc "Popular GNU data compression program"
  homepage "https://www.gnu.org/software/gzip"
  url "http://ftpmirror.gnu.org/gzip/gzip-1.6.tar.gz"
  mirror "https://ftp.gnu.org/gnu/gzip/gzip-1.6.tar.gz"
  sha256 "97eb83b763d9e5ad35f351fe5517e6b71521d7aac7acf3e3cacdb6b1496d8f7e"

  bottle do
    cellar :any
    revision 1
    sha256 "4f4a5361da0eb9b1f8769e9da586cb21f8b261bbd814afa00773d98c864c4797" => :yosemite
    sha256 "f899ced33032b5fd323c0bc592345f7f2f02dedaadc5a0061b10e8780f1797da" => :mavericks
    sha256 "605ab80dff19ad7dad9e95af772ffe45d5968738d5dbcece62be244acb789137" => :mountain_lion
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
