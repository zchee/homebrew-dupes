require 'formula'

class Fetchmail < Formula
  homepage 'http://www.fetchmail.info/'
  url 'http://downloads.sourceforge.net/project/fetchmail/branch_6.3/fetchmail-6.3.25.tar.xz'
  sha1 'a246a6a3caf90e1106448c9dde4463e87d816031'

  depends_on 'xz' => :build

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}", "--with-ssl"
    system "make install"
  end
end
