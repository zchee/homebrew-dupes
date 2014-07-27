require 'formula'

class Libpcap < Formula
  homepage 'http://www.tcpdump.org/'
  url 'http://www.tcpdump.org/release/libpcap-1.6.1.tar.gz'
  sha1 '71ef78dc41ae12eec51726cff52721721b2db548'

  head 'git://bpf.tcpdump.org/libpcap'

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-ipv6",
                          "--disable-universal"
    system "make install"
  end
end
