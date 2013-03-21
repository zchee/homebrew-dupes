require 'formula'

class Whois < Formula
  homepage 'http://packages.debian.org/sid/whois'
  url 'http://ftp.debian.org/debian/pool/main/w/whois/whois_5.0.20.tar.xz'
  sha1 '0fe1c6b4cc8434bb7f4af1a51bae82868208c50b'

  depends_on 'xz' => :build

  def install
    system "make whois"
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
