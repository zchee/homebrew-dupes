class Whois < Formula
  homepage "https://packages.debian.org/sid/whois"
  url "https://mirrors.kernel.org/debian/pool/main/w/whois/whois_5.2.7.tar.xz"
  mirror "https://mirrors.ocf.berkeley.edu/debian/pool/main/w/whois/whois_5.2.7.tar.xz"
  sha256 "c5536161a26c28ea0de03fafc065b5ce1b272a8ad2b44bf5784e7e802e61f239"
  head "https://github.com/rfc1036/whois.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-dupes"
    cellar :any
    sha256 "24081efbc758c5bcf03b98f8abb37396c7473fa1378732d53c486fd3639584e2" => :yosemite
    sha256 "c4d134beeb590af732c4a0ceea5d5add7cb6ed5fd73b4b416bd4e1da750ede14" => :mavericks
    sha256 "4df8c9210b3b088ed9029e6ae09fd5b2b62499d8acf03b07ff179d5a92a90a1d" => :mountain_lion
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
