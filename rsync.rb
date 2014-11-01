require 'formula'

class Rsync < Formula
  homepage 'https://rsync.samba.org/'
  url 'https://rsync.samba.org/ftp/rsync/rsync-3.1.1.tar.gz'
  sha1 'c84faba04f721d393feccfa0476bfeed9b5b5250'

  depends_on "autoconf" => :build

  patch do
    url "https://trac.macports.org/export/127713/trunk/dports/net/rsync/files/patch-fileflags.diff"
    sha1 "4ecd6496642800d5da7931796eb56a92ca233671"
  end

  patch do
    url "https://trac.macports.org/export/127713/trunk/dports/net/rsync/files/patch-crtimes.diff"
    sha1 "cf07fd4bdf09744f16dfd8f605f5f849a651f641"
  end

  patch do
    url "https://trac.macports.org/export/127713/trunk/dports/net/rsync/files/patch-hfs-compression.diff"
    sha1 "6dd10b8e3f8067930cd8405982d20421222fa680"
  end

  def install
    system "./prepare-source"
    system "./configure", "--disable-debug",
                          "--prefix=#{prefix}",
                          "--with-rsyncd-conf=#{etc}/rsyncd.conf",
                          "--enable-ipv6"
    system "make"
    system "make install"
  end
end
