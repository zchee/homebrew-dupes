require 'formula'

class Ant < Formula
  homepage 'http://ant.apache.org/'
  url 'http://www.apache.org/dyn/closer.cgi?path=ant/binaries/apache-ant-1.8.4-bin.tar.gz'
  sha1 'b4a7b2d0dfba23ba970973e4881b5b5634fbdfaf'

  def install
    rm Dir['bin/*.{bat,cmd,dll,exe}']
    libexec.install Dir['*']

    bin.mkpath
    Dir["#{libexec}/bin/*"].each do |f|
      ln_s f, bin+File.basename(f)
    end
  end

  def test
    system "ant -version"
  end
end
