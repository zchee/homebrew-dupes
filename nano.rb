class Nano < Formula
  desc "A free (GNU) replacement for the Pico text editor"
  homepage "http://www.nano-editor.org/"
  url "http://www.nano-editor.org/dist/v2.4/nano-2.4.2.tar.gz"
  sha256 "c8cd7f18fcf5696d9df3364ee2a840e0ab7b6bdbd22abf850bbdc951db7f65b9"
  revision 1

  bottle do
    cellar :any
    sha256 "010966def823ea6dc03295f7837223b4b5e8c452d2bed239a2dd3713a2f7b600" => :yosemite
    sha256 "4e4825037227279cc22e29599b3117bdebeea6fe187defac2f0d8bed602bb08d" => :mavericks
    sha256 "3c3cb8348b0049ea8472bd41b556188abfff63859fc0cd7b32a96e71887ecd20" => :mountain_lion
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
