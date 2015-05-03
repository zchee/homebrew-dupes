class Nano < Formula
  homepage "http://www.nano-editor.org/"
  url "http://www.nano-editor.org/dist/v2.4/nano-2.4.1.tar.gz"
  sha256 "6a0ceb5e1b9b9bea72d5d1f46488ace4782b1f198ea6ba558480a86d994f29d2"

  head do
    url "svn://svn.sv.gnu.org/nano/trunk/nano"
    depends_on "automake" => :build
    depends_on "autoconf" => :build
  end

  bottle do
    root_url "https://homebrew.bintray.com/bottles-dupes"
    cellar :any
    sha256 "07b30e22f69316405f54c9ff3d89a2a1d51d0ee6a4aac8a7a6f11a9e48c1e357" => :yosemite
    sha256 "9d366dc0b1f08fe5de353730091eaf8ece41199ab058f9d2875d1ca77cc92c70" => :mavericks
    sha256 "c600e37f85012c4b2369cbab556627f116e1de35b7f211baf33326ad1da5edcf" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "homebrew/dupes/ncurses"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--enable-color",
                          "--enable-extra",
                          "--enable-multibuffer",
                          "--enable-nanorc",
                          "--disable-nls",
                          "--enable-utf8"
    system "make", "install"
  end

  test do
    system "#{bin}/nano", "--version"
  end
end
