class Bzip2 < Formula
  homepage "http://www.bzip.org/"
  url "http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz"
  sha1 "3f89f861209ce81a6bab1fd1998c0ef311712002"
  revision 1

  bottle do
    sha1 "1ea6b36d9ebfa233d6df6e4db5456c475f0e28ec" => :yosemite
    sha1 "2b1929e2d5f732f37195527e21efdc3bae6097fb" => :mavericks
    sha1 "700e622444ffae3796ed14fd83fcb93923529152" => :mountain_lion
  end

  keg_only :provided_by_osx

  def install
    system "make", "install", "PREFIX=#{prefix}"
    share.install "#{prefix}/man"
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
