require 'formula'

class Lapack < Formula
  homepage 'http://www.netlib.org/lapack/'
  url 'http://www.netlib.org/lapack/lapack-3.4.2.tgz'
  sha1 '93a6e4e6639aaf00571d53a580ddc415416e868b'

  depends_on :fortran
  depends_on 'cmake' => :build

  keg_only :provided_by_osx

  def install
    system "cmake", ".", "-DCMAKE_INSTALL_PREFIX:PATH=#{prefix}", "-DBUILD_SHARED_LIBS:BOOL=ON", "-DLAPACKE:BOOL=ON"
    system "make", "install"
  end
end
