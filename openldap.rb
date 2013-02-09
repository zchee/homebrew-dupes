require 'formula'

class Openldap < Formula
  homepage 'http://www.openldap.org/software/'
  url 'ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.33.tgz'
  sha1 '0cea642ba2dae1eb719da41bfedb9eba72ad504d'

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
