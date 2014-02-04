require 'formula'

class Grep < Formula
  homepage 'http://www.gnu.org/software/grep/'
  url 'http://ftpmirror.gnu.org/grep/grep-2.16.tar.xz'
  mirror 'http://ftp.gnu.org/gnu/grep/grep-2.16.tar.xz'
  sha256 '16dfeb5013d8c9f21f40ccec0936f2c1c6a014c828d30488f0d5c6ef7b551162'

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
  end unless build.include? 'default-names'
end
