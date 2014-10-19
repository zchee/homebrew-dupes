require 'formula'

# "File" is a reserved class name
class FileFormula < Formula
  homepage 'http://www.darwinsys.com/file/'
  url 'ftp://ftp.astron.com/pub/file/file-5.18.tar.gz'
  mirror 'http://fossies.org/unix/misc/file-5.18.tar.gz'
  sha1 '8753e72097f2cc935608e3b1c57c4c4e31bd8d21'

  head 'https://github.com/glensc/file.git'

  keg_only :provided_by_osx

  # Marked as fixed upstream, but not yet in a release
  # See http://bugs.gw.com/view.php?id=230
  patch :DATA if MacOS.version < :lion

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-fsect-man5"
    system "make install"
  end
end

__END__
diff --git a/src/getline.c b/src/getline.c
index e3c41c4..74c314e 100644
--- a/src/getline.c
+++ b/src/getline.c
@@ -76,7 +76,7 @@ getdelim(char **buf, size_t *bufsiz, int delimiter, FILE *fp)
  }
 }
 
-ssize_t
+public ssize_t
 getline(char **buf, size_t *bufsiz, FILE *fp)
 {
  return getdelim(buf, bufsiz, '\n', fp);
