require 'formula'

class Rsync < Formula

  # NOTE: we're pusing 3.0.9 on purpose. 3.1.0 has a protocol bug in
  # it that has not, to our knowledge, been fixed yet. If you propose
  # an update to this formula, you need to test this across two
  # machines with the same version.

  homepage 'https://rsync.samba.org/'
  url 'https://rsync.samba.org/ftp/rsync/src/rsync-3.0.9.tar.gz'
  sha1 'c64c8341984aea647506eb504496999fd968ddfc'

  depends_on :autoconf

  def patches
    %W[
      https://gitweb.samba.org/?p=rsync-patches.git;a=blob_plain;hb=v3.0.9;f=fileflags.diff
      https://gitweb.samba.org/?p=rsync-patches.git;a=blob_plain;hb=v3.0.9;f=crtimes.diff
      https://gitweb.samba.org/?p=rsync-patches.git;a=blob_plain;hb=v3.0.9;f=hfs-compression.diff
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
