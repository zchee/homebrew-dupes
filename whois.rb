class Whois < Formula
  homepage "https://packages.debian.org/sid/whois"
  url "https://mirrors.kernel.org/debian/pool/main/w/whois/whois_5.2.7.tar.xz"
  mirror "https://mirrors.ocf.berkeley.edu/debian/pool/main/w/whois/whois_5.2.7.tar.xz"
  sha256 "c5536161a26c28ea0de03fafc065b5ce1b272a8ad2b44bf5784e7e802e61f239"
  head "https://github.com/rfc1036/whois.git"

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/dupes"
    cellar :any
    sha1 "5d87f8328466ed9b9b8a59e1486c26b58d7da45d" => :yosemite
    sha1 "8c22dda5e3bc601d26c933254b5d97b8f90db3c4" => :mavericks
    sha1 "4134fa42e1410fad594e688079ee59f679f4f429" => :mountain_lion
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
