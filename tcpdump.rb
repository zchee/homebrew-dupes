require 'formula'

class Tcpdump < Formula
  homepage 'http://www.tcpdump.org/'
  url 'http://www.tcpdump.org/release/tcpdump-4.3.0.tar.gz'
  sha1 '5d0432e4831ca81633a6c9da732caad77d64a9ac'

  head 'git://bpf.tcpdump.org/tcpdump'

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-ipv6",
                          "--disable-smb",
                          "--disable-universal"
    system "make install"
  end
end
