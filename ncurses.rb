require 'formula'

class Ncurses < Formula
  homepage 'http://www.gnu.org/s/ncurses/'
  url 'http://ftpmirror.gnu.org/ncurses/ncurses-5.9.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/ncurses/ncurses-5.9.tar.gz'
  sha1 '3e042e5f2c7223bffdaac9646a533b8c758b65b5'

  keg_only :provided_by_osx

  option :universal

  # Fix building C++ bindings with clang
  def patches
    { :p0 => "https://trac.macports.org/export/103963/trunk/dports/devel/ncurses/files/constructor_types.diff" }
  end

  def install
    ENV.universal_binary if build.universal?

    system "./configure", "--disable-debug",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--with-shared",
                          "--enable-widec",
                          "--with-manpage-format=normal",
                          "--enable-symlinks"
    system "make"
    system "make install"
  end
end
