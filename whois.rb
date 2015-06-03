class Whois < Formula
  homepage "https://packages.debian.org/sid/whois"
  url "https://mirrors.kernel.org/debian/pool/main/w/whois/whois_5.2.8.tar.xz"
  mirror "https://mirrors.ocf.berkeley.edu/debian/pool/main/w/whois/whois_5.2.8.tar.xz"
  sha256 "f053ebe766f7a6f42859e6a4abd3f18741f9788aaeb1b129c3c8de95085635da"
  head "https://github.com/rfc1036/whois.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-dupes"
    cellar :any
    sha256 "b402d57c730b0cd1b89feef657e743e439d9953bfc3034b5406be6b1a3de26e7" => :yosemite
    sha256 "a3e411c6ac489f265e259bcdc0a8c3453f7f8b7ce879ace1a15219f210d73a48" => :mavericks
    sha256 "4d7ae1143cc46ad0110658a2e9e5fa9d449913c7a5f39a1a526f69f4e59450e8" => :mountain_lion
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
