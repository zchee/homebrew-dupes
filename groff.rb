require 'formula'

class Groff < Formula
  homepage 'http://www.gnu.org/software/groff/'
  url 'http://ftpmirror.gnu.org/groff/groff-1.22.2.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/groff/groff-1.22.2.tar.gz'
  sha1 '37223941e25bb504bf54631daaabb01b147dc1d3'

  option 'with-gropdf', 'Enable PDF output support'
  option 'with-grohtml', 'Enable HTML output support (implies --with-gropdf)'
  option 'with-gpresent', 'Install macros for the presentations document format'

  if build.with? "grohtml"
    depends_on "ghostscript"
    depends_on "netpbm"
    depends_on "psutils"
  elsif build.with? "gropdf"
    depends_on "ghostscript"
  end

  resource 'gpresent' do
    url 'https://staff.fnwi.uva.nl/b.diertens/useful/gpresent/gpresent-2.3.tar.gz'
    sha1 '7d38165ad87ce418458275d0c04388dd0c651431'
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--without-x"
    system "make" # Separate steps required
    system "make install"

    if build.with? 'gpresent'
      resource('gpresent').stage do
        (share/'groff/site-tmac').install Dir['*.tmac']
        (share/'groff/examples').install Dir['*.rof', '*.pdf']
        man7.install Dir['*.7']
        man1.install Dir['*.1']
        bin.install 'presentps'
      end
    end
  end

  def caveats
    <<-EOS.undent
    Attempting to use PDF or HTML output support without using --with-gropdf or
    --with-grohtml may result in errors.
    EOS
  end
end
