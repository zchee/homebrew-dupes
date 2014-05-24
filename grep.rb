require "formula"

class Grep < Formula
  homepage "http://www.gnu.org/software/grep/"
  url "http://ftpmirror.gnu.org/grep/grep-2.19.tar.xz"
  mirror "http://ftp.gnu.org/gnu/grep/grep-2.19.tar.xz"
  sha256 "6388295be48cfcaf7665d9cd3914e6625ea000e9414132bfefd45cf1d8eec34d"

  depends_on "pcre"

  option "default-names", "Do not prepend 'g' to the binary"

  def install
    pcre = Formula["pcre"].opt_prefix
    ENV.append "LDFLAGS", "-L#{pcre}/lib -lpcre"
    ENV.append "CPPFLAGS", "-I#{pcre}/include"

    args = %W[
      --disable-dependency-tracking
      --disable-nls
      --prefix=#{prefix}
      --infodir=#{info}
      --mandir=#{man}
    ]

    args << "--program-prefix=g" unless build.include? "default-names"

    system "./configure", *args
    system "make"
    system "make install"
  end

  def caveats; <<-EOS.undent
    The command has been installed with the prefix "g".
    If you do not want the prefix, install using the "default-names" option.
    EOS
  end unless build.include? "default-names"

  test do
    text_file = (testpath/"file.txt")
    text_file.write "This line should be matched"
    cmd = (build.include?("default-names")) ? "grep" : "ggrep"
    grepped = `#{bin}/#{cmd} "match" #{text_file}`
    assert_match /should be matched/, grepped
    assert_equal 0, $?.exitstatus
  end
end
