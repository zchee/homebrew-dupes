class Tcpdump < Formula
  homepage "http://www.tcpdump.org/"
  url "http://www.tcpdump.org/release/tcpdump-4.7.3.tar.gz"
  sha256 "1f87fb652ce996d41e7a06c601bc6ea29b13fee922945b23770c29490f1d8ace"

  head "https://github.com/the-tcpdump-group/tcpdump.git"

  depends_on "homebrew/dupes/libpcap" => :optional
  depends_on "openssl"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--enable-ipv6",
                          "--disable-smb",
                          "--disable-universal"
    system "make", "install"
  end

  test do
    system sbin/"tcpdump", "--help"
  end
end
