require 'formula'

# "File" is a reserved class name
class FileFormula < Formula
  homepage 'http://www.darwinsys.com/file/'
  url 'ftp://ftp.astron.com/pub/file/file-5.17.tar.gz'
  mirror 'http://fossies.org/unix/misc/file-5.17.tar.gz'
  sha1 'f7e837a0d3e4f40a02ffe7da5e146b967448e0d8'

  head 'https://github.com/glensc/file.git'

  keg_only :provided_by_osx

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-fsect-man5"
    system "make install"
  end
end
