require 'formula'

class Openldap < Formula
  homepage 'http://www.openldap.org/software/'
  url 'ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.39.tgz'
  sha256 '8267c87347103fef56b783b24877c0feda1063d3cb85d070e503d076584bf8a7'

  depends_on 'berkeley-db' => :optional

  def install
    args = %W[--disable-dependency-tracking
              --prefix=#{prefix}
              --sysconfdir=#{etc}
              --localstatedir=#{var}]

    args << "--enable-bdb=no" unless build.with? "berkeley-db"
    args << "--enable-hdb=no" unless build.with? "berkeley-db"

    system "./configure", *args
    system "make install"
    (var+'run').mkpath
  end
end
