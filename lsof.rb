require 'formula'

class Lsof < Formula
  homepage 'http://people.freebsd.org/~abe/'
  url 'ftp://sunsite.ualberta.ca/pub/Mirror/lsof/lsof_4.88.tar.bz2'
  sha1 '09db6d2cd96bc6832d9b767084b9c67cf5cf52bb'

  def install
    system "tar xf lsof_4.88_src.tar"
    cd "lsof_4.88_src" do
      mv "00README", "../README"
      system "./Configure -n darwin"
      system "make"
      bin.install "lsof"
    end
  end
end
