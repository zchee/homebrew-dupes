require "formula"

class Heimdal < Formula
  homepage "http://www.h5l.org"
  url "http://www.h5l.org/dist/src/heimdal-1.6rc2.tar.gz"
  sha1 "f129ec039c7b62ea8226d907db270f1cc0bca7d3"
  revision 1

  keg_only :provided_by_osx

  depends_on :x11 => :recommended

  def install
      args = %W[
          --disable-debug
          --disable-dependency-tracking
          --prefix=#{prefix}
      ]

      args << "--without-x" if build.without? "x11"

      system "./configure", *args
      system "make", "install"
  end
end
