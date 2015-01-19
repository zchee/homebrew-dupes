class Units < Formula
  homepage 'https://www.gnu.org/software/units/'
  url 'http://ftpmirror.gnu.org/units/units-2.01.tar.gz'
  mirror 'https://ftp.gnu.org/gnu/units/units-2.01.tar.gz'
  sha1 '80e7f1a2e70769bfac93702924871843b85f12d4'

  keg_only :provided_by_osx,
    "OS X provides BSD units, which behaves differently from GNU units."

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make check"

    ENV.deparallelize # units install otherwise races to make some directories
    system "make install"
  end

  test do
    system %{[ $("#{bin}/units" '(((square(kiloinch)+2.84m2) /0.5) meters^2)^(1|4)' m | sed -n -e 's/[[:space:]]\\\* //p') = 6 ]}
  end
end
