class Rsync < Formula
  homepage "https://rsync.samba.org/"
  url "https://rsync.samba.org/ftp/rsync/rsync-3.1.1.tar.gz"
  mirror "https://mirrors.kernel.org/debian/pool/main/r/rsync/rsync_3.1.1.orig.tar.gz"
  sha1 "c84faba04f721d393feccfa0476bfeed9b5b5250"

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/dupes"
    cellar :any
    sha1 "cf5893932a9dbe9b2b48940f1842143e0580d4b3" => :yosemite
    sha1 "c1981da705dd7ab4ebd4cfb31646b1f7dbe7a771" => :mavericks
    sha1 "39f694183b78f127511a011bc5bd6becff2d9993" => :mountain_lion
  end

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
    system "make", "install"
  end

  test do
    system bin/"rsync", "--version"
  end
end
