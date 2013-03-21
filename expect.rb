require 'formula'

class Expect < Formula
  homepage 'http://expect.sourceforge.net'
  url 'http://downloads.sourceforge.net/project/expect/Expect/5.45/expect5.45.tar.gz'
  sha1 'e634992cab35b7c6931e1f21fbb8f74d464bd496'

  option 'enable-threads', 'Build with multithreading support'

  def install
    args = ["--prefix=#{prefix}", "--exec-prefix=#{prefix}", "--mandir=#{man}"]
    args << "--enable-shared"
    args << "--enable-threads" if build.include? "enable-threads"
    args << "--enable-64bit" if MacOS.prefer_64_bit?

    system "./configure", *args
    system "make"
    system "make install"
  end

  test do
    system "#{bin}/mkpasswd"
  end
end
