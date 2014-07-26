require 'formula'

class Nano < Formula
  homepage 'http://www.nano-editor.org/'
  url 'http://www.nano-editor.org/dist/v2.3/nano-2.3.4.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/nano/nano-2.3.4.tar.gz'
  sha1 '1e315518b59755ab23f86b95786d55ebcc02941a'

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
