require 'formula'

class Ant < Formula
  homepage 'http://ant.apache.org/'
  url 'http://www.apache.org/dyn/closer.cgi?path=ant/binaries/apache-ant-1.9.2-bin.tar.gz'
  sha1 'fa2c18a27cdf407f5d8306bbc0f0b29513d915d8'

  def install
    rm Dir['bin/*.{bat,cmd,dll,exe}']
    libexec.install Dir['*']

    bin.mkpath
    Dir["#{libexec}/bin/*"].each do |f|
      ln_s f, bin+File.basename(f)
    end
  end

  test do
    system "ant", "-version"
  end
end
