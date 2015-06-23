class Lapack < Formula
  homepage "http://www.netlib.org/lapack/"
  url "http://www.netlib.org/lapack/lapack-3.5.0.tgz"
  sha1 "5870081889bf5d15fd977993daab29cf3c5ea970"

  resource "manpages" do
    url "http://netlib.org/lapack/manpages.tgz"
    version "3.5.0"
    sha1 "fb5829fca324f7a2053409b370d58e60f3aa4e6e"
  end

  depends_on :fortran
  depends_on "cmake" => :build

  keg_only :provided_by_osx

  def install
    system "cmake", ".", "-DBUILD_SHARED_LIBS:BOOL=ON", "-DLAPACKE:BOOL=ON", *std_cmake_args
    system "make", "install"
    man.install resource("manpages")
  end
end
