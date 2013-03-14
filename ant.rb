require 'formula'

class Ant < Formula
  homepage 'http://ant.apache.org/'
  url 'http://www.apache.org/dyn/closer.cgi?path=ant/binaries/apache-ant-1.9.0-bin.tar.gz'
  sha1 '791418e7e80e3f28d6347528e8992a14f09058e7'

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
