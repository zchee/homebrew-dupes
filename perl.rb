require 'formula'

class Perl < Formula
  homepage 'http://www.perl.org/'
  url 'http://www.cpan.org/src/5.0/perl-5.14.4.tar.gz'
  sha1 '2fdbbf39b3bbd79e42a7cf42fc05bf9891f077a1'

  option 'use-threads', 'Enable Perl threads'

  def install
    args = [
        '-des',
        "-Dprefix=#{prefix}",
        "-Dman1dir=#{man1}",
        "-Dman3dir=#{man3}",
        '-Duseshrplib',
        '-Duselargefiles',
    ]

    args << '-Dusethreads' if build.include? 'use-threads'

    system './Configure', *args
    system "make"
    system "make test"
    system "make install"
  end

  def caveats
    unless build.include? 'use-threads' then <<-EOS.undent
      Builds without threads by default. Use --use-threads to build with threads.
      EOS
    end
  end
end
