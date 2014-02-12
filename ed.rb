require 'formula'

class Ed < Formula
  homepage 'http://www.gnu.org/software/ed/ed.html'
  url 'http://ftpmirror.gnu.org/ed/ed-1.9.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/ed/ed-1.9.tar.gz'
  sha1 'a7f01929eb9ae5fe2d3255cd99e41a2211571984'

  option 'default-names', "Don't prepend 'g' to the binaries"

  def install
    args = ["--prefix=#{prefix}"]
    args << "--program-prefix=g" unless build.include? 'default-names'
    ENV.j1
    system "./configure", *args
    system "make"
    system "make install"
  end

  test do
    options = Tab.for_formula('ed').used_options
    ed = options.any? {|t| t.name == 'default-names'} ? 'ed' : 'ged'
    system bin/ed, "--version"
  end

  def caveats; <<-EOS.undent
    The command has been installed with the prefix 'g'.
    If you do not want the prefix, install using the 'default-names' option.
    EOS
  end
end
