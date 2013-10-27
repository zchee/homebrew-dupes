require 'formula'

class Grep < Formula
  homepage 'http://www.gnu.org/software/grep/'
  url 'http://ftpmirror.gnu.org/grep/grep-2.15.tar.xz'
  mirror 'http://ftp.gnu.org/gnu/grep/grep-2.15.tar.xz'
  sha256 'bf5a834e587974c8c64e71b35b9e75cd21c7ff253c0e7fbfb0a78be794965314'

  depends_on 'xz' => :build
  depends_on 'pcre'

  option 'default-names', "Do not prepend 'g' to the binary"

  def install
    pcre = Formula.factory('pcre').opt_prefix
    ENV.append 'LDFLAGS', "-L#{pcre}/lib -lpcre"
    ENV.append 'CPPFLAGS', "-I#{pcre}/include"

    args = %W[
      --disable-dependency-tracking
      --disable-nls
      --prefix=#{prefix}
      --infodir=#{info}
      --mandir=#{man}
    ]

    args << "--program-prefix=g" unless build.include? 'default-names'

    system "./configure", *args
    system "make"
    system "make install"
  end

  def caveats; <<-EOS.undent
    The command has been installed with the prefix 'g'.
    If you do not want the prefix, install using the 'default-names' option.
    EOS
  end
end
