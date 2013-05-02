require 'formula'

class Groff < Formula
  homepage 'http://www.gnu.org/software/groff/'
  url 'http://ftpmirror.gnu.org/groff/groff-1.22.2.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/groff/groff-1.22.2.tar.gz'
  sha1 '37223941e25bb504bf54631daaabb01b147dc1d3'

  # TODO: Add option for using system's ghostscript instead of
  # installing homebrewed version. That allows this to play nice with,
  # e.g., MacTex (which install its own ghostscript.)  The ./configure
  # option --with-gs=PATH may be of use. We could also set ghostscript
  # as build-only dependency, though that may cause groff to always look
  # at that (temp) path for gs.
  option 'with-gropdf', 'Enable PDF output support'
  option 'with-grohtml', 'Enable HTML output support (implies --with-gropdf)'

  # gs needed for both PDF and HTML output
  depends_on 'ghostscript' if (build.with? 'gropdf' or build.with? 'grohtml')
  # To support HTML/XHTML output, ./configure looks for `pnmcut',
  # `pnmcrop', `pnmtopng', `psselect', and `pnmtops'. HTML/XHTML may
  # still work without these, but only if the output doesn't include
  # tables, images, or other graphical elements.
  depends_on 'netpbm' if build.with? 'grohtml'
  depends_on 'psutils' if build.with? 'grohtml'

  def patches
    # The patched bug is only hit if --with-grohtml is used, cuasing
    # configure to find pnmtops
    DATA if build.with? 'grohtml'
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--without-x"
    system "make" # Separate steps required
    system "make install"
  end

  def caveats
    <<-EOS.undent
    Attempting to use PDF or HTML output support without using --with-gropdf or
    --with-grohtml may result in errors.
    EOS
  end
end

# Fix a bug where ./configure would hang trying to execute a shell
# command with a '|' in it.
__END__
diff --git a/configure b/configure
index 63e9e5d..6f97736 100755
--- a/configure
+++ b/configure
@@ -10440,18 +10440,8 @@ $as_echo "$as_me: WARNING: missing program$plural:



-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking whether pnmtops can handle the -nosetpage option" >&5
-$as_echo_n "checking whether pnmtops can handle the -nosetpage option... " >&6; }
-   if echo P2 2 2 255 0 1 2 0 | pnmtops -nosetpage > /dev/null 2>&1 ; then
-     { $as_echo "$as_me:${as_lineno-$LINENO}: result: yes" >&5
-$as_echo "yes" >&6; }
-     pnmtops_nosetpage="pnmtops -nosetpage"
-   else
-     { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-     pnmtops_nosetpage="pnmtops"
-   fi

+pnmtops_nosetpage="pnmtops -nosetpage"

     { $as_echo "$as_me:${as_lineno-$LINENO}: checking whether we are using the GNU C Library >= 2.1 or uClibc" >&5
 $as_echo_n "checking whether we are using the GNU C Library >= 2.1 or uClibc... " >&6; }
