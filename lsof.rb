require 'formula'

class Lsof < Formula
  homepage 'http://people.freebsd.org/~abe/'
  url 'ftp://sunsite.ualberta.ca/pub/Mirror/lsof/lsof_4.87.tar.bz2'
  sha1 '68e61e0a45491420ace80770157206328c27d8c4'

  def install
    system "tar xf lsof_4.87_src.tar"
    cd "lsof_4.87_src" do
      mv "00README", "../README"
      system "./Configure -n darwin"
      system "make"
      bin.install "lsof"
    end
  end
end
