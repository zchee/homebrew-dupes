class Openldap < Formula
  homepage "http://www.openldap.org/software/"
  url "ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.40.tgz"
  mirror "http://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.4.40.tgz"
  sha256 "d12611a5c25b6499293c2bb7b435dc2b174db73e83f5a8cb7e34f2ce5fa6dadb"

  depends_on "berkeley-db" => :optional
  depends_on "openssl"

  option "with-memberof", "Include memberof overlay"
  option "with-unique", "Include unique overlay"
  option "with-sssvlv", "Enable server side sorting and virtual list view"

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
    ]

    args << "--enable-bdb=no" << "--enable-hdb=no" if build.without? "berkeley-db"
    args << "--enable-memberof" if build.with? "memberof"
    args << "--enable-unique" if build.with? "unique"
    args << "--enable-sssvlv=yes" if build.with? "sssvlv"

    system "./configure", *args
    system "make", "install"
    (var+"run").mkpath

    # https://github.com/Homebrew/homebrew-dupes/pull/452
    chmod 0755, Dir[etc/"openldap/*"]
    chmod 0755, Dir[etc/"openldap/schema/*"]
  end
end
