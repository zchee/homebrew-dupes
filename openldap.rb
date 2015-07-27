class Openldap < Formula
  desc "Open source suite of directory software"
  homepage "http://www.openldap.org/software/"
  url "ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.41.tgz"
  mirror "http://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.4.41.tgz"
  sha256 "27856bb4a8b44feca2b326c309000e16a9dadd52362c8ab6eec6c67a43737f6e"
  revision 1

  bottle do
    sha256 "eca10b85f3e58fa93dbd8893395fcea91e73eb1778f5d478e7d11d4238b723f6" => :yosemite
    sha256 "f3ce96592df9560e6be00fb9ff8735000622ed4d25078183d12d0765b7d266bf" => :mavericks
    sha256 "09a80c94749de9223f6b924a8a61f4a2269d117b5337a0f811faf3ecf292d5a6" => :mountain_lion
  end

  option "with-memberof", "Include memberof overlay"
  option "with-unique", "Include unique overlay"
  option "with-sssvlv", "Enable server side sorting and virtual list view"

  depends_on "berkeley-db" => :optional
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
