require "formula"

class Whois < Formula
  homepage "https://packages.debian.org/sid/whois"
  url "http://ftp.us.debian.org/debian/pool/main/w/whois/whois_5.2.0.tar.xz"
  sha1 "1678a34b7b055750ba6f10d93eaa3b6c63993645"

  depends_on "xz" => :build

  def install
    system "make HAVE_ICONV=1 whois_LDADD+=-liconv whois"
    bin.install "whois"
    man1.install "whois.1"
  end

  def caveats; <<-EOS.undent
    Debian whois has been installed as `whois` and may shadow the
    system binary of the same name.
    EOS
  end

  test do
    system "#{bin}/whois"
  end
end
