require 'formula'

class Apr < Formula
  homepage 'http://apr.apache.org/'
  url 'http://www.apache.org/dyn/closer.cgi?path=apr/apr-1.4.8.tar.bz2'
  sha1 '2dce90291b6d4072a6e47d096f5c81ae1ce76f9f'

  keg_only :provided_by_osx

  def install
    # Compilation will not complete without deparallelize
    ENV.deparallelize

    system "./configure", "--disable-debug", "--prefix=#{prefix}"
    system "make install"
  end
end
