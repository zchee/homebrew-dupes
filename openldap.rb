class Openldap < Formula
  desc "Open source suite of directory software"
  homepage "http://www.openldap.org/software/"
  url "ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.41.tgz"
  mirror "http://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.4.41.tgz"
  sha256 "27856bb4a8b44feca2b326c309000e16a9dadd52362c8ab6eec6c67a43737f6e"
  revision 1

  bottle do
    cellar :any
    sha256 "602e052825d5ccaf264b64460c7023f68d6c624c387ab193136d019865ccdeb4" => :yosemite
    sha256 "c400fe53bb22ee3d3804b93d6db489b9e84ab68ddd30b4d45536eb9599090c34" => :mavericks
    sha256 "2f44209c7df982d6030c4250d01707c01d2058f7a2af4b1d95b3c47cd98b98e5" => :mountain_lion
  end

  option "with-memberof", "Include memberof overlay"
  option "with-unique", "Include unique overlay"
  option "with-sssvlv", "Enable server side sorting and virtual list view"

  depends_on "berkeley-db4" => :optional
  depends_on "openssl"

  keg_only :provided_by_osx

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
