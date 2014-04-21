require "formula"

class Screen < Formula
  homepage "http://www.gnu.org/software/screen"

  stable do
    url "http://ftpmirror.gnu.org/screen/screen-4.2.1.tar.gz"
    mirror "http://ftp.gnu.org/gnu/screen/screen-4.2.1.tar.gz"
    version "4.2.1"
    sha1 "21eadf5f1d64120649f3390346253c6bc8a5103c"
  end

  head do
    url "git://git.savannah.gnu.org/screen.git", :branch => "master"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  # This patch is to disable the error message
  # "/var/run/utmp: No such file or directory" on launch
  patch build.head? ? :p1 : :p2 do
    url "https://gist.github.com/raw/4608863/75669072f227b82777df25f99ffd9657bd113847/gistfile1.diff"
    sha1 "93d611f1f46c7bbca5f9575304913bd1c38e183b"
  end

  def install
    if build.head?
      cd "src"
    end

    # With parallel build, it fails
    # because of trying to compile files which depend osdef.h
    # before osdef.sh script generates it.
    ENV.deparallelize

    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--infodir=#{info}",
                          "--enable-colors256"
    system "make"
    system "make install"
  end
end
