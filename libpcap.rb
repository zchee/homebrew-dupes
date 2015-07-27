class Libpcap < Formula
  desc "Portable library for network traffic capture"
  homepage "http://www.tcpdump.org/"
  url "http://www.tcpdump.org/release/libpcap-1.7.4.tar.gz"
  sha256 "7ad3112187e88328b85e46dce7a9b949632af18ee74d97ffc3f2b41fe7f448b0"

  keg_only :provided_by_osx

  head "git://bpf.tcpdump.org/libpcap"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--enable-ipv6",
                          "--disable-universal"
    system "make", "install"
  end

  test do
    assert_match /lpcap/, shell_output("#{bin}/pcap-config --libs")
  end
end
