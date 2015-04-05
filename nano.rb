require 'formula'

class Nano < Formula
  homepage 'http://www.nano-editor.org/'
  url 'http://www.nano-editor.org/dist/v2.4/nano-2.4.0.tar.gz'
  sha1 '55639cbac2d38febf16780b912b036f2023534d1'
  head 'svn://svn.sv.gnu.org/nano/trunk/nano'
  bottle do
    root_url "https://homebrew.bintray.com/bottles-dupes"
    cellar :any
    sha256 "07b30e22f69316405f54c9ff3d89a2a1d51d0ee6a4aac8a7a6f11a9e48c1e357" => :yosemite
    sha256 "9d366dc0b1f08fe5de353730091eaf8ece41199ab058f9d2875d1ca77cc92c70" => :mavericks
    sha256 "c600e37f85012c4b2369cbab556627f116e1de35b7f211baf33326ad1da5edcf" => :mountain_lion
  end

  # see https://savannah.gnu.org/bugs/?44609
  patch :DATA

  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "homebrew/dupes/ncurses"

  def install
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
    system "make install"
  end

  test do
    system "#{bin}/nano", "--version"
  end
end

__END__
--- a/src/text.c	2015-03-22 23:45:12.000000000 -0400
+++ b/src/text.c	2015-03-24 22:44:05.000000000 -0400
@@ -2664,7 +2664,7 @@ const char *do_alt_speller(char *tempfil
     ssize_t current_y_save = openfile->current_y;
     ssize_t lineno_save = openfile->current->lineno;
     struct stat spellfileinfo;
-    __time_t timestamp;
+    time_t timestamp;
     pid_t pid_spell;
     char *ptr;
     static int arglen = 3;
