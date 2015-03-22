class Tidy < Formula
  homepage "http://tidy.sourceforge.net/"
  stable do
    url "ftp://mirror.internode.on.net/pub/gentoo/distfiles/tidy-20090325.tar.bz2"
    sha1 "28c000a2cd40262fc0d7c2c429eb2a09b2df7bf4"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end
  bottle do
    root_url "https://homebrew.bintray.com/bottles-dupes"
    cellar :any
    sha256 "5d7af2612e3a655e0175c0e211e62c0e67fff96b09e4fe4a656110e4c56c38cc" => :yosemite
    sha256 "4981468de3c4ad2b1782a0696f7ed1a5cb83d100636d344bdfb0390040a218ed" => :mavericks
    sha256 "7ba5a97814d0f73385dcdd2431bcbc3376f43246448e43c2abe340335a14352b" => :mountain_lion
  end


  head do
    # Head homepage is now "http://www.html-tidy.org/".
    url "https://github.com/htacg/tidy-html5.git"

    depends_on "cmake" => :build
  end

  def install
    if build.stable?
      system "sh", "build/gnuauto/setup.sh"
      system "./configure", "--disable-debug",
                            "--disable-dependency-tracking",
                            "--prefix=#{prefix}",
                            "--mandir=#{man}"
      system "make", "install"
    else
      cd "build/cmake" do
        system "cmake", "../..", *std_cmake_args
        system "make", "install"
      end
      # Binary is now named 'tidy5' so symlink it to 'tidy'.
      bin.install_symlink "tidy5" => "tidy"
    end
  end
end
