require "formula"

class Ed < Formula
  homepage "https://www.gnu.org/software/ed/ed.html"
  url "http://ftpmirror.gnu.org/ed/ed-1.10.tar.lz"
  mirror "https://ftp.gnu.org/gnu/ed/ed-1.10.tar.lz"
  sha1 "aba379f59b98ee4bae8f76f92b563827bd9e0e19"

  option "default-names", "Don't prepend 'g' to the binaries"

  def install
    args = ["--prefix=#{prefix}"]
    args << "--program-prefix=g" unless build.include? "default-names"
    ENV.j1
    system "./configure", *args
    system "make"
    system "make install"
  end

  test do
    system Dir["#{bin}/{g,}ed"].first, "--version"
  end

  def caveats; <<-EOS.undent
    The command has been installed with the prefix 'g'.
    If you do not want the prefix, install using the 'default-names' option.
    EOS
  end
end
