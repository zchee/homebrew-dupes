require 'formula'

class Rsync < Formula
  homepage 'http://rsync.samba.org/'
  url 'http://rsync.samba.org/ftp/rsync/src/rsync-3.1.0.tar.gz'
  sha1 'eb58ab04bcb6293da76b83f58327c038b23fcba3'

  depends_on :autoconf

  def patches
    %W[
      http://gitweb.samba.org/?p=rsync-patches.git;a=blob_plain;f=fileflags.diff;hb=v3.1.0
      http://gitweb.samba.org/?p=rsync-patches.git;a=blob_plain;f=crtimes.diff;hb=v3.1.0
      http://gitweb.samba.org/?p=rsync-patches.git;a=blob_plain;f=hfs-compression.diff;hb=v3.1.0
    ]
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
