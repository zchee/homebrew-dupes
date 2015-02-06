class Krb5 < Formula
  homepage "http://web.mit.edu/kerberos/"
  url "http://web.mit.edu/kerberos/dist/krb5/1.13/krb5-1.13-signed.tar"
  sha256 "dc8f79ae9ab777d0f815e84ed02ac4ccfe3d5826eb4947a195dfce9fd95a9582"

  keg_only :provided_by_osx

  depends_on "openssl"

  def install
    system "tar", "zxf", "krb5-#{version}.tar.gz"
    cd "krb5-#{version}/src" do
      system "./configure",
        "--disable-debug",
        "--disable-dependency-tracking",
        "--disable-silent-rules",
        "--prefix=#{prefix}"
      system "make"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/krb5-config", "--version"
    `#{bin}/krb5-config --cflags`.include? include
  end
end
