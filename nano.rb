class Nano < Formula
  desc "A free (GNU) replacement for the Pico text editor"
  homepage "http://www.nano-editor.org/"
  url "http://www.nano-editor.org/dist/v2.4/nano-2.4.2.tar.gz"
  sha256 "c8cd7f18fcf5696d9df3364ee2a840e0ab7b6bdbd22abf850bbdc951db7f65b9"
  revision 1

  bottle do
    cellar :any
    sha256 "f282672a102b5b9f1034c3ee46792394b341dce14856dc6746cb56ae15eda6f2" => :yosemite
    sha256 "9803757b95a170d6bcc1ca7a60a78b2e5c964d0d5af17e700b8aafcf3d9a9528" => :mavericks
    sha256 "25623a18d91f5325386e2e25cab2137e54a5d02b71657931024c731916dcf58a" => :mountain_lion
  end

  head do
    url "svn://svn.sv.gnu.org/nano/trunk/nano"
    depends_on "automake" => :build
    depends_on "autoconf" => :build
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
