require 'formula'

class Heimdal < Formula
  homepage 'http://www.h5l.org'
  url 'http://h5l.org/dist/src/heimdal-1.5.2.tar.gz'
  sha1 'dd0920a181d18236432e4b3e5eab6e468cda4b89'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
