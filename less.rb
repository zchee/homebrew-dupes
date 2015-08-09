class Less < Formula
  homepage "http://www.greenwoodsoftware.com/less/index.html"
  url "http://www.greenwoodsoftware.com/less/less-458.tar.gz"
  sha256 "e536c7819ede54b3d487f0ffc4c14b3620bed83734d92a81e89f62346db0fcac"

  devel do
    url "http://greenwoodsoftware.com/less/less-471.tar.gz"
    sha256 "37f613fa9a526378788d790a92217d59b523574cf7159f6538da8564b3fb27f8"
  end

  depends_on "pcre" => :optional

  def install
    args = ["--prefix=#{prefix}"]
    args << "--with-regex=pcre" if build.with? "pcre"
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/lesskey", "-V"
  end
end
