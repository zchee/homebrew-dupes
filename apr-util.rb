require 'formula'

class AprUtil < Formula
  homepage 'http://apr.apache.org/'
  url 'http://www.apache.org/dyn/closer.cgi?path=apr/apr-util-1.5.2.tar.bz2'
  sha1 '67139f51ee6c484f3f1b7b3edc0b00dae3640b0a'

  keg_only :provided_by_osx

  depends_on 'apr'

  def install
    # Compilation will not complete without deparallelize
    ENV.deparallelize

    system "./configure", "--disable-debug", "--prefix=#{prefix}",
                          "--with-apr=#{Formula.factory('apr').opt_prefix}"
    system "make"
    system "make install"
  end
end
