require 'formula'

class Whois < Formula
  homepage 'http://packages.debian.org/sid/whois'
  url 'http://ftp.us.debian.org/debian/pool/main/w/whois/whois_5.1.2.tar.xz'
  sha1 '627c7437f663657db903e0cf4ee0cc1369f63e96'

  depends_on 'xz' => :build

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
