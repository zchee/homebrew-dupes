require "formula"

class Libedit < Formula
  homepage "http://thrysoee.dk/editline/"
  url "http://thrysoee.dk/editline/libedit-20140620-3.1.tar.gz"
  version "3.1"
  sha1 "9c0fc40ac9336af9af0799bcdfd3537a6ad258ff"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-dupes"
    cellar :any
    sha1 "95b8fe87ed59a7ed75a4f2b2bb4aa11f68b300eb" => :yosemite
    sha1 "b612eee30295d66ea08c79cc3dddec8d93ab91af" => :mavericks
    sha1 "6031695f7acf4ef5dd367b5175c0c7bb7cd489ed" => :mountain_lion
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--enable-widec",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
