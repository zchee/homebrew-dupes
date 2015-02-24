require "formula"

class Make < Formula
  homepage "https://www.gnu.org/software/make/"
  url "http://ftpmirror.gnu.org/make/make-4.1.tar.bz2"
  mirror "https://ftp.gnu.org/gnu/make/make-4.1.tar.bz2"
  sha1 "0d701882fd6fd61a9652cb8d866ad7fc7de54d58"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-dupes"
    sha1 "f00ac977b231d51962c59977d77de991899357aa" => :yosemite
    sha1 "ff3f5a9ae60bcfe187cd1ddc02521d4d702705be" => :mavericks
    sha1 "04e443efa9d4d3968b530252f59c57663d58c8bf" => :mountain_lion
  end

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
