require 'formula'

class Openssh < Formula
  homepage 'http://www.openssh.com/'
  url 'http://ftp5.usa.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-6.2p1.tar.gz'
  version '6.2p1'
  sha1 '8824708c617cc781b2bb29fa20bd905fd3d2a43d'

  option 'with-brewed-openssl', 'Build with Homebrew OpenSSL instead of the system version'

  depends_on 'openssl' if build.with? 'brewed-openssl'
  depends_on 'ldns' => :optional
  depends_on 'pkg-config' => :build if build.with? "ldns"

  def install
    args = %W[
      --with-libedit
      --prefix=#{prefix}
    ]

    args << "--with-ssl-dir=#{Formula.factory('openssl').opt_prefix}" if build.with? 'brewed-openssl'
    args << "--with-ldns" if build.with? "ldns"

    system "./configure", *args
    system "make"
    system "make install"
  end
end
