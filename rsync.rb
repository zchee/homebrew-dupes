class Rsync < Formula
  desc "Utility that provides fast incremental file transfer"
  homepage "https://rsync.samba.org/"
  url "https://rsync.samba.org/ftp/rsync/rsync-3.1.1.tar.gz"
  mirror "https://mirrors.kernel.org/debian/pool/main/r/rsync/rsync_3.1.1.orig.tar.gz"
  sha256 "7de4364fcf5fe42f3bdb514417f1c40d10bbca896abe7e7f2c581c6ea08a2621"

  bottle do
    cellar :any
    sha1 "cf5893932a9dbe9b2b48940f1842143e0580d4b3" => :yosemite
    sha1 "c1981da705dd7ab4ebd4cfb31646b1f7dbe7a771" => :mavericks
    sha1 "39f694183b78f127511a011bc5bd6becff2d9993" => :mountain_lion
  end

  depends_on "autoconf" => :build

  if OS.mac?
    patch do
      url "https://trac.macports.org/export/127713/trunk/dports/net/rsync/files/patch-fileflags.diff"
      sha256 "b50f0ad6d2c20e561e17b64f07545b1ecfe7d61481a6e5af192abfe21af01e73"
    end

    patch do
      url "https://trac.macports.org/export/127713/trunk/dports/net/rsync/files/patch-crtimes.diff"
      sha256 "396e552b1f51ee10c21f27afc73b75b2d421272443d15d2a5539ac641c32cbb1"
    end

    patch do
      url "https://trac.macports.org/export/127713/trunk/dports/net/rsync/files/patch-hfs-compression.diff"
      sha256 "134483ab33fdaa67d503dc4011656913321f9e405639fab96d48ef54e08dfa1f"
    end
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
