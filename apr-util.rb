require 'formula'

class AprUtil < Formula
  homepage 'http://apr.apache.org/'
  url 'http://archive.apache.org/dist/apr/apr-util-1.5.1.tar.bz2'
  sha1 '084000daa76b85a4e7021b1847840ca8fea3736c'

  keg_only :provided_by_osx

  depends_on 'apr'

  def install
    # Compilation will not complete without deparallelize
    ENV.deparallelize

    system "./configure", "--disable-debug", "--prefix=#{prefix}",
                          "--with-apr=#{Formula.factory('apr').opt_prefix}"
    system "make install"
  end
end
