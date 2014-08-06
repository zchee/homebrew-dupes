require 'formula'

class Nano < Formula
  homepage 'http://www.nano-editor.org/'
  url 'http://www.nano-editor.org/dist/v2.3/nano-2.3.6.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/nano/nano-2.3.6.tar.gz'
  sha1 '7dd39f21bbb1ab176158e0292fd61c47ef681f6d'

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
end
