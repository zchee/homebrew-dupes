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
    sha256 "c0c8f2d22095fb8e0ee2ed7304a0c9c3218361d7ac5e89438dc824f9e8b03dd7" => :yosemite
    sha256 "1f7eeb6de531029a388ce39b0caf4a220e97d24557ed2a9dd3b990714ad8ee72" => :mavericks
    sha256 "7ff1b6fd739a14179e3bd7ce85527f333cbbee9a25615ee7185bcc7f8da363e0" => :mountain_lion
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
