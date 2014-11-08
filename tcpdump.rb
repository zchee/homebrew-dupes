require "formula"

class Tcpdump < Formula
  homepage "http://www.tcpdump.org/"
  url "http://www.tcpdump.org/release/tcpdump-4.6.2.tar.gz"
  sha1 "7256c47e572229de8c92f070514c1f6e6bb691d4"

  head "git://bpf.tcpdump.org/tcpdump"

  depends_on "homebrew/dupes/libpcap" => :optional
  depends_on "openssl"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--enable-ipv6",
                          "--disable-smb",
                          "--disable-universal"
    system "make", "install"
  end
end
