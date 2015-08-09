class Lapack < Formula
  homepage "http://www.netlib.org/lapack/"
  url "http://www.netlib.org/lapack/lapack-3.5.0.tgz"
  sha256 "9ad8f0d3f3fb5521db49f2dd716463b8fb2b6bc9dc386a9956b8c6144f726352"

  bottle do
    cellar :any
    sha256 "b492305db3e74f7fde1d1798fbbb653c9caea0f7436e8bda5af2c19677909fc0" => :yosemite
    sha256 "c099b310cbe3217266a9316cff77471c1c72ad0203def9776c851609e38ea789" => :mavericks
    sha256 "cd6aea6fb9bc22942172bb532a0e6836320b28406341985a11fe9d1dd9ee62ff" => :mountain_lion
  end

  resource "manpages" do
    url "http://netlib.org/lapack/manpages.tgz"
    version "3.5.0"
    sha256 "055da7402ea807cc16f6c50b71ac63d290f83a5f2885aa9f679b7ad11dd8903d"
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
