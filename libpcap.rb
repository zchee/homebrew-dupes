require "formula"

class Libpcap < Formula
  homepage "http://www.tcpdump.org/"
  url "http://www.tcpdump.org/release/libpcap-1.6.2.tar.gz"
  sha1 "7efc7d56f4959de8bb33a92de2e15d92105eac32"
  revision 1

  keg_only :provided_by_osx

  head "git://bpf.tcpdump.org/libpcap"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--enable-ipv6",
                          "--disable-universal"
    system "make", "install"
  end
end
