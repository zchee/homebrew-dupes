require 'formula'

class Awk < Formula
  homepage 'http://www.cs.princeton.edu/~bwk/btl.mirror/'
  url 'http://www.cs.princeton.edu/~bwk/btl.mirror/awk.tar.gz'
  version '20121220'
  sha1 '538fd69fb0fd01966eb41ad20c336215b4a07301'

  def install
    ENV.O3 # Docs recommend higher optimization
    # the yacc command the makefile uses results in build failures:
    # /usr/bin/bison: missing operand after `awkgram.y'
    # makefile believes -S to use sprintf instead of sprint, but the
    # -S flag is not supported by `bison -y`
    inreplace "makefile" do |s|
      s.change_make_var! 'YACC', 'yacc -d'
    end
    system "make", "CC=#{ENV.cc}", "CFLAGS=#{ENV.cflags}"
    bin.install 'a.out' => 'awk'
    man1.install 'awk.1'
  end
end
