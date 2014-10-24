require 'formula'

class Rsync < Formula
  homepage 'https://rsync.samba.org/'
  url 'https://rsync.samba.org/ftp/rsync/rsync-3.1.1.tar.gz'
  sha1 'c84faba04f721d393feccfa0476bfeed9b5b5250'

  depends_on "autoconf" => :build

  patch do
    url "https://git.samba.org/?p=rsync-patches.git;a=blob_plain;hb=v3.1.1;f=fileflags.diff"
    sha1 "71b88f5958f88f5c5664ed4ee10957a7dee10ff3"
  end

  patch do
    url "https://git.samba.org/?p=rsync-patches.git;a=blob_plain;hb=v3.1.1;f=crtimes.diff"
    sha1 "d00a104eb18177d5106ccc057cbd7e54b2693447"
  end

  patch do
    url "https://git.samba.org/?p=rsync-patches.git;a=blob_plain;hb=v3.1.1;f=hfs-compression.diff"
    sha1 "b5698b26ae358658207ce3627c20aef605b6ddd4"
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
