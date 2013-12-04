require 'formula'

# "File" is a reserved class name
class FileFormula < Formula
  homepage 'http://www.darwinsys.com/file/'
  url 'ftp://ftp.astron.com/pub/file/file-5.15.tar.gz'
  mirror 'http://fossies.org/unix/misc/file-5.15.tar.gz'
  sha1 'de1a060aa5fe61c1a6f0359fb526e824b4244323'

  head 'https://github.com/glensc/file.git'

  keg_only :provided_by_osx

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--bindir=#{libexec}",
                          "--enable-fsect-man5"
    system "make install"

    # one of the regexes in file 5.15 fails when the locale is
    # set to UTF-8, so force C; reported upstream:
    # http://bugs.gw.com/view.php?id=292
    (bin/'file').write <<-EOS.undent
    #!/bin/bash
    LC_CTYPE=C exec #{libexec}/file $@
    EOS
  end
end
