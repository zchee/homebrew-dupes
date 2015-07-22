class Diffstat < Formula
  homepage "http://invisible-island.net/diffstat/"
  url "https://mirrors.kernel.org/debian/pool/main/d/diffstat/diffstat_1.59.orig.tar.gz"
  mirror "https://mirrors.ocf.berkeley.edu/debian/pool/main/d/diffstat/diffstat_1.59.orig.tar.gz"
  sha256 "267d1441b8889cbefbb7ca7dfd4a17f6c8bc73bc114904c74ecad945a3dbf270"

  bottle do
    cellar :any
    sha256 "30e038e6f68b2fb44f0e629d306adde9f8eb38bdb78bf8a8f5f69ba15cb0aefd" => :yosemite
    sha256 "8784f071d32a78b18ccdbe00e4ad5a3909559e8896b9de4e78bccdad67b5a1e8" => :mavericks
    sha256 "d0688255b63ac7a7e3fcd012fb6aef427669ce464e38155345fdddbb4c49e88c" => :mountain_lion
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"diff.diff").write <<-EOS.undent
      diff --git a/diffstat.rb b/diffstat.rb
      index 596be42..5ff14c7 100644
      --- a/diffstat.rb
      +++ b/diffstat.rb
      @@ -2,9 +2,8 @@
      -  url 'http://invisible-island.net/datafiles/release/diffstat.tar.gz'
      -  version '1.58'
      -  sha1 '7a67ecb996ea65480bd0b9db33d8ed458e5f2a24'
      +  url 'ftp://invisible-island.net/diffstat/diffstat-1.58.tgz'
      +  sha256 'fad5135199c3b9aea132c5d45874248f4ce0ff35f61abb8d03c3b90258713793'
    EOS
    output = `#{bin}/diffstat diff.diff`
    diff = <<-EOS
 diffstat.rb |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
    EOS
    assert_equal diff, output
  end
end
