require "formula"

class Make < Formula
  homepage "https://www.gnu.org/software/make/"
  url "http://ftpmirror.gnu.org/make/make-4.1.tar.bz2"
  mirror "https://ftp.gnu.org/gnu/make/make-4.1.tar.bz2"
  sha1 "0d701882fd6fd61a9652cb8d866ad7fc7de54d58"

  keg_only :provided_by_osx

  depends_on "guile" => :optional

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]

    args << "--with-guile" if build.with? "guile"
    system "./configure", *args
    system "make", "install"
  end
end
