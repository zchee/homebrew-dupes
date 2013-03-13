require 'formula'

class Heimdal < Formula
  homepage 'http://www.h5l.org'
  url 'http://h5l.org/dist/src/heimdal-1.5.2.tar.gz'
  sha1 'dd0920a181d18236432e4b3e5eab6e468cda4b89'

  depends_on :x11 => :recommended

  def install
      args = %W[
          --disable-debug
          --disable-dependency-tracking
          --prefix=#{prefix}
      ]

      args << "--without-x" unless build.with? "x11"

      system "./configure", *args
      system "make install"
  end
end
