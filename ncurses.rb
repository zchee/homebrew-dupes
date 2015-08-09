class Ncurses < Formula
  desc "Text-based UI library"
  homepage "https://www.gnu.org/s/ncurses/"
  url "http://ftpmirror.gnu.org/ncurses/ncurses-6.0.tar.gz"
  mirror "https://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz"
  sha256 "f551c24b30ce8bfb6e96d9f59b42fbea30fa3a6123384172f9e7284bcf647260"

  bottle do
    sha256 "1cbfe34e03d1005cd7ebf69250b3427b25969c4b7b3a81bd72e0a768d8f6a98b" => :yosemite
    sha256 "3f0b3398050ce5efb40adad245b868233f140f7365c7e4cc2a02ddf276066fe6" => :mavericks
    sha256 "66f88fb4d3930ebbd94b064e65dc22929c11bb49f215d8c84df7af733bd86e16" => :mountain_lion
  end

  keg_only :provided_by_osx

  option :universal

  def install
    ENV.universal_binary if build.universal?

    # Fix the build for GCC 5.1
    # error: expected ')' before 'int' in definition of macro 'mouse_trafo'
    # See http://lists.gnu.org/archive/html/bug-ncurses/2014-07/msg00022.html
    # and http://trac.sagemath.org/ticket/18301
    # Disable linemarker output of cpp
    ENV.append "CPPFLAGS", "-P"

    ENV["PKG_CONFIG_LIBDIR"] = "#{lib}/pkgconfig"
    (lib/"pkgconfig").mkpath

    system "./configure", "--prefix=#{prefix}",
                          "--enable-pc-files",
                          "--enable-sigwinch",
                          "--enable-symlinks",
                          "--enable-widec",
                          "--mandir=#{man}",
                          "--with-manpage-format=normal",
                          "--with-shared"
    system "make", "install"
    make_libncurses_symlinks

    prefix.install "test"
    (prefix/"test").install "install-sh", "config.sub", "config.guess"
  end

  def make_libncurses_symlinks
    major = version.to_s.split(".")[0]

    cd lib do
      %w[form menu ncurses panel].each do |name|
        if OS.mac?
          ln_s "lib#{name}w.#{major}.dylib", "lib#{name}.dylib"
          ln_s "lib#{name}w.#{major}.dylib", "lib#{name}.#{major}.dylib"
        else
          ln_s "lib#{name}w.so.#{major}", "lib#{name}.so"
          ln_s "lib#{name}w.so.#{major}", "lib#{name}.so.#{major}"
        end
        ln_s "lib#{name}w.a", "lib#{name}.a"
        ln_s "lib#{name}w_g.a", "lib#{name}_g.a"
      end

      ln_s "libncurses++w.a", "libncurses++.a"
      ln_s "libncurses.a", "libcurses.a"
      if OS.mac?
        ln_s "libncurses.dylib", "libcurses.dylib"
      else
        ln_s "libncurses.so", "libcurses.so"
      end
    end

    cd bin do
      ln_s "ncursesw#{major}-config", "ncurses#{major}-config"
    end

    ln_s [
      "ncursesw/curses.h", "ncursesw/form.h", "ncursesw/ncurses.h",
      "ncursesw/term.h", "ncursesw/termcap.h"], include
  end

  test do
    ENV["TERM"] = "xterm"
    system bin/"tput", "cols"

    cd prefix/"test" do
      system "./configure", "--prefix=#{testpath}/test",
                            "--with-curses-dir=#{prefix}"
      system "make", "install"
    end
    system testpath/"test/bin/keynames"
    system testpath/"test/bin/test_arrays"
    system testpath/"test/bin/test_vidputs"
  end
end
