require 'formula'

class Make < Formula
  homepage 'http://www.gnu.org/software/make/'
  url 'http://ftpmirror.gnu.org/make/make-4.0.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/make/make-4.0.tar.gz'
  sha1 'b092020919f74d56118eafac2c202f25ff3b6e59'

  keg_only :provided_by_osx

  depends_on 'guile' => :optional

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]

    args << '--with-guile' if build.with? 'guile'
    system './configure', *args
    system "make install"
  end
end
