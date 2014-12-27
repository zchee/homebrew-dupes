require "formula"

class Lsof < Formula
  homepage "http://people.freebsd.org/~abe/"
  url "ftp://sunsite.ualberta.ca/pub/Mirror/lsof/lsof_4.88.tar.bz2"
  sha1 "09db6d2cd96bc6832d9b767084b9c67cf5cf52bb"

  def install
    ENV["LSOF_INCLUDE"] = "#{MacOS.sdk_path}/usr/include"

    system "tar", "xf", "lsof_#{version}_src.tar"

    cd "lsof_#{version}_src" do
      # Source hardcodes full header paths at /usr/include
      inreplace %w[dialects/darwin/kmem/dlsof.h dialects/darwin/kmem/machine.h
                   dialects/darwin/libproc/machine.h],
                "/usr/include", MacOS.sdk_path.to_s + "/usr/include"

      mv "00README", "../README"
      system "./Configure", "-n", "darwin"
      system "make"
      bin.install "lsof"
    end
  end
end
