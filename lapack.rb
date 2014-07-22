require 'formula'

class Lapack < Formula
  homepage 'http://www.netlib.org/lapack/'
  url 'http://www.netlib.org/lapack/lapack-3.5.0.tgz'
  sha1 '5870081889bf5d15fd977993daab29cf3c5ea970'

  depends_on :fortran
  depends_on 'cmake' => :build

  keg_only :provided_by_osx

  def install
    system "cmake", ".", "-DCMAKE_INSTALL_PREFIX:PATH=#{prefix}", "-DBUILD_SHARED_LIBS:BOOL=ON", "-DLAPACKE:BOOL=ON"
    system "make", "install"
  end
end
