require 'formula'

class Openldap < Formula
  homepage 'http://www.openldap.org/software/'
  url 'ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.24.tgz'
  sha1 'a4baad3d45ae5810ba5fee48603210697c70d52f'

  depends_on 'berkeley-db' => :optional

  skip_clean 'var/run'

  def install
    args = %W[--disable-dependency-tracking
              --prefix=#{prefix}
              --sysconfdir=#{etc}]

    args << "--enable-bdb=no" unless build.with? "berkeley-db"
    args << "--enable-hdb=no" unless build.with? "berkeley-db"

    system "./configure", *args
    system "make install"
    (var+'run').mkpath
  end
end
