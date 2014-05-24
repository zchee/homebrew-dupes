require "formula"

class Screen < Formula
  homepage "http://www.gnu.org/software/screen"

  stable do
    url "http://ftpmirror.gnu.org/screen/screen-4.0.3.tar.gz"
    mirror "http://ftp.gnu.org/gnu/screen/screen-4.0.3.tar.gz"
    version "4.00.03"
    sha1 "7bc6e2f0959ffaae6f52d698c26c774e7dec3545"

    patch do
      url "http://trac.macports.org/raw-attachment/ticket/20862/screen-4.0.3-snowleopard.patch"
      sha1 "850aa680a5ce704ce56541eb023edd2c0285fa9a"
    end
  end

  head do
    url "git://git.savannah.gnu.org/screen.git", :branch => "master"
    depends_on "autoconf" => :build
    depends_on "automake" => :build

    # This patch is to disable the error message
    # "/var/run/utmp: No such file or directory" on launch
    patch do
      url "https://gist.github.com/raw/4608863/75669072f227b82777df25f99ffd9657bd113847/gistfile1.diff"
      sha1 "93d611f1f46c7bbca5f9575304913bd1c38e183b"
    end
  end

  def install
    if build.head?
      cd "src"
      system "./autogen.sh"

      # With parallel build, it fails
      # because of trying to compile files which depend osdef.h
      # before osdef.sh script generates it.
      ENV.deparallelize
    end

    system "./configure", "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--infodir=#{info}",
                          "--enable-colors256"
    system "make"
    system "make install"
  end
end
