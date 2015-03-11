require 'formula'

class Expect < Formula
  homepage 'http://expect.sourceforge.net'
  url 'https://downloads.sourceforge.net/project/expect/Expect/5.45/expect5.45.tar.gz'
  sha1 'e634992cab35b7c6931e1f21fbb8f74d464bd496'

  bottle do
    root_url "https://homebrew.bintray.com/bottles-dupes"
    sha256 "40ca4ae627a226a7b27a4117998f99463a4544031933f711b06ff8144a295f09" => :yosemite
    sha256 "acbc838215f029f3a0afe17b8f388c4f5c5e4e31312d92d99e1dd7528f33eb0f" => :mavericks
    sha256 "59d6fc12a4ce841bd6c6cf77493ec8ab3dd4e061c899373e5b70c39d81a819bb" => :mountain_lion
  end

  option 'enable-threads', 'Build with multithreading support'
  option 'with-brewed-tk', "Use Homebrew's Tk (has optional Cocoa and threads support)"

  depends_on 'homebrew/dupes/tcl-tk' if build.with? 'brewed-tk'

  # Autotools are introduced here to regenerate configure script. Remove
  # if the patch has been applied in newer releases.
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  # Fix Tcl private header detection.
  # https://sourceforge.net/p/expect/patches/17/
  patch do
    url "https://sourceforge.net/p/expect/patches/17/attachment/expect_detect_tcl_private_header_os_x_mountain_lion.patch"
    sha1 "396c2672ec50d64f83002b950ca48420363b942f"
  end

  def install
    args = ["--prefix=#{prefix}", "--exec-prefix=#{prefix}", "--mandir=#{man}"]
    args << "--enable-shared"
    args << "--enable-threads" if build.include? "enable-threads"
    args << "--enable-64bit" if MacOS.prefer_64_bit?
    args << "--with-tcl=#{Formula["tcl-tk"].opt_prefix}/lib" if build.with? 'brewed-tk'

    # Regenerate configure script. Remove after patch applied in newer
    # releases.
    system "autoreconf", "--force", "--install", "--verbose"

    system "./configure", *args
    system "make"
    system "make install"
    lib.install_symlink Dir[lib/"expect*/libexpect*"]
  end

  test do
    system "#{bin}/mkpasswd"
  end
end
