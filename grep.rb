class Grep < Formula
  homepage "https://www.gnu.org/software/grep/"
  url "http://ftpmirror.gnu.org/grep/grep-2.21.tar.xz"
  mirror "https://ftp.gnu.org/gnu/grep/grep-2.21.tar.xz"
  sha256 "5244a11c00dee8e7e5e714b9aaa053ac6cbfa27e104abee20d3c778e4bb0e5de"

  depends_on "pcre"

  option "with-default-names", "Do not prepend 'g' to the binary"
  deprecated_option "default-names" => "with-default-names"

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

    args << "--program-prefix=g" if build.without? "default-names"

    system "./configure", *args
    system "make"
    system "make install"
  end

  def caveats
    if build.without? "default-names" then <<-EOS.undent
      The command has been installed with the prefix "g".
      If you do not want the prefix, install using the "with-default-names"
      option.
      EOS
    end
  end

  test do
    text_file = testpath/"file.txt"
    text_file.write "This line should be matched"
    cmd = build.with?("default-names") ? "grep" : "ggrep"
    grepped = shell_output("#{bin}/#{cmd} 'match' #{text_file}")
    assert_match /should be matched/, grepped
  end
end
