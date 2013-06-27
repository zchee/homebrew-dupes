require 'formula'

class Lapack < Formula
  homepage 'http://www.netlib.org/lapack/'
  url 'http://www.netlib.org/lapack/lapack-3.4.2.tgz'
  sha1 '93a6e4e6639aaf00571d53a580ddc415416e868b'

  depends_on :fortran

  keg_only :provided_by_osx

  def install
    # Copy over make.inc, to load in configuration for this platform
    mv "INSTALL/make.inc.gfortran", "make.inc"
    system "make", "lib"
    lib.install "liblapack.a"
  end
end
