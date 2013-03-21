require 'formula'

class Less < Formula
  homepage 'http://www.greenwoodsoftware.com/less/index.html'
  url 'http://www.greenwoodsoftware.com/less/less-451.tar.gz'
  sha1 'ee95be670e8fcc97ac87d02dd1980209130423d0'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end

  test do
    system "#{bin}/lesskey"
  end
end
