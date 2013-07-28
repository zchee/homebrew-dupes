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
