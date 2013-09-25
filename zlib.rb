require 'formula'

class Zlib < Formula
  homepage 'http://www.zlib.net/'
  url 'http://zlib.net/zlib-1.2.8.tar.gz'
  sha1 'a4d316c404ff54ca545ea71a27af7dbc29817088'

  keg_only :provided_by_osx

  option :universal

  def patches
    # configure script fails to detect the right compiler when "cc" is the
    # default compiler. zlib mantainers have been notified of the issue.
    DATA
  end

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end
end

__END__
diff --git a/configure b/configure
index b77a8a8..54f33f7 100755
--- a/configure
+++ b/configure
@@ -159,6 +159,7 @@ case "$cc" in
 esac
 case `$cc -v 2>&1` in
   *gcc*) gcc=1 ;;
+  *clang*) gcc=1 ;;
 esac
 
 show $cc -c $test.c
