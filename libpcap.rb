require 'formula'

class Libpcap < Formula
  homepage 'http://www.tcpdump.org/'
  url 'http://www.tcpdump.org/release/libpcap-1.3.0.tar.gz'
  sha1 '90aa2f0fcfb4bf79fc50ccdaa70f484d96295be3'

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
