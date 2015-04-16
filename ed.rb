class Ed < Formula
  homepage "https://www.gnu.org/software/ed/ed.html"
  url "http://ftpmirror.gnu.org/ed/ed-1.11.tar.lz"
  mirror "https://ftp.gnu.org/gnu/ed/ed-1.11.tar.lz"
  sha256 "bd146ede5f225e20946ad94ef6bdf07939313bcc41dde5d2beedcea1a147a134"

  deprecated_option "default-names" => "with-default-names"
  option "with-default-names", "Don't prepend 'g' to the binaries"

  def install
    ENV.j1

    args = ["--prefix=#{prefix}"]
    args << "--program-prefix=g" if build.without? "default-names"

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test").write "Hello world"
    `echo ',s/o//\nw' | #{bin}/ged -s #{testpath}/test`
    assert_equal "Hell world", (testpath/"test").read.chomp
  end

  def caveats
    if build.without? "default-names" then <<-EOS.undent
      The command has been installed with the prefix "g".
      If you do not want the prefix, reinstall using the "with-default-names" option.
      EOS
    end
  end
end
