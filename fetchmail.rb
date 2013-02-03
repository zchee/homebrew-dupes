require 'formula'

class Fetchmail < Formula
  homepage 'http://www.fetchmail.info/'
  url 'http://downloads.sourceforge.net/project/fetchmail/branch_6.3/fetchmail-6.3.24.tar.xz'
  sha1 '8cb2aa3a85dd307ccd1899ddbb4463e011048535'

  depends_on 'xz' => :build

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}", "--with-ssl"
    system "make install"
  end
end
