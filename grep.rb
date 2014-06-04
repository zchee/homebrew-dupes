require "formula"

class Grep < Formula
  homepage "https://www.gnu.org/software/grep/"
  url "http://ftpmirror.gnu.org/grep/grep-2.20.tar.xz"
  mirror "https://ftp.gnu.org/gnu/grep/grep-2.20.tar.xz"
  sha256 "f0af452bc0d09464b6d089b6d56a0a3c16672e9ed9118fbe37b0b6aeaf069a65"

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
