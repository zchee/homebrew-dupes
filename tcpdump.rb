class Tcpdump < Formula
  desc "Command-line packet analyzer"
  homepage "http://www.tcpdump.org/"
  url "http://www.tcpdump.org/release/tcpdump-4.7.4.tar.gz"
  sha256 "6be520269a89036f99c0b2126713a60965953eab921002b07608ccfc0c47d9af"

  head "https://github.com/the-tcpdump-group/tcpdump.git"

  bottle do
    cellar :any
    sha256 "7512e22e9879515f92613f03ffb7fd0f81803bff91ab3baf21adeb48f1425574" => :yosemite
    sha256 "24e411be0b985c24f5d0acabe92962ccdd417a14bb8cc978b708052579093dce" => :mavericks
    sha256 "6da076e421f7c30961795281e57e68f43b5405f071d409ce557ba1fe09fb7ae5" => :mountain_lion
  end

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
