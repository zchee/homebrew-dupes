class Bzip2 < Formula
  desc "Freely available high-quality data compressor"
  homepage "http://www.bzip.org/"
  url "http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz"
  sha256 "a2848f34fcd5d6cf47def00461fcb528a0484d8edef8208d6d2e2909dc61d9cd"
  revision 1

  bottle do
    sha1 "1ea6b36d9ebfa233d6df6e4db5456c475f0e28ec" => :yosemite
    sha1 "2b1929e2d5f732f37195527e21efdc3bae6097fb" => :mavericks
    sha1 "700e622444ffae3796ed14fd83fcb93923529152" => :mountain_lion
  end

  keg_only :provided_by_osx

  def install
    inreplace "Makefile", "$(PREFIX)/man", "$(PREFIX)/share/man"

    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    testfilepath = testpath + "sample_in.txt"
    zipfilepath = testpath + "sample_in.txt.bz2"

    testfilepath.write "TEST CONTENT"

    system "#{bin}/bzip2", testfilepath
    system "#{bin}/bunzip2", zipfilepath

    assert_equal "TEST CONTENT", testfilepath.read
  end
end
