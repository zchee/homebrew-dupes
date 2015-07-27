class Libedit < Formula
  desc "BSD-style licensed readline alternative"
  homepage "http://thrysoee.dk/editline/"
  url "http://thrysoee.dk/editline/libedit-20150325-3.1.tar.gz"
  version "20150325-3.1"
  sha256 "c88a5e4af83c5f40dda8455886ac98923a9c33125699742603a88a0253fcc8c5"

  bottle do
    cellar :any
    sha1 "95b8fe87ed59a7ed75a4f2b2bb4aa11f68b300eb" => :yosemite
    sha1 "b612eee30295d66ea08c79cc3dddec8d93ab91af" => :mavericks
    sha1 "6031695f7acf4ef5dd367b5175c0c7bb7cd489ed" => :mountain_lion
  end

  keg_only :provided_by_osx

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--enable-widec",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
