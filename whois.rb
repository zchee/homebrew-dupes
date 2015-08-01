class Whois < Formula
  desc "Lookup tool for domain names and other internet resources"
  homepage "https://packages.debian.org/sid/whois"
  url "https://mirrors.kernel.org/debian/pool/main/w/whois/whois_5.2.10.tar.xz"
  mirror "https://mirrors.ocf.berkeley.edu/debian/pool/main/w/whois/whois_5.2.10.tar.xz"
  sha256 "8acb42bc693f73f3141b413f7df11b5582b9b738d9bf0d60e9017a8af4cb53b9"
  head "https://github.com/rfc1036/whois.git"

  bottle do
    cellar :any
    sha256 "0cecc8a12250f3f4191d7165900c462ec9b45ec7d0c642750a346c184aede3e4" => :yosemite
    sha256 "fa889a2636074009c92049ceeacdaa4412b24f6d5b9f47ca07d769b48fa8a027" => :mavericks
    sha256 "c72b46d290bc3ea83976445af7525d2c0fe845127df06186643c918ab14f2d31" => :mountain_lion
  end

  def install
    # autodie was not shipped with the system perl 5.8
    inreplace "make_version_h.pl", "use autodie;", "" if MacOS.version < :snow_leopard

    system "make", "HAVE_ICONV=1", "whois_LDADD+=-liconv", "whois"
    bin.install "whois"
    man1.install "whois.1"
  end

  def caveats; <<-EOS.undent
    Debian whois has been installed as `whois` and may shadow the
    system binary of the same name.
    EOS
  end

  test do
    system "#{bin}/whois", "brew.sh"
  end
end
