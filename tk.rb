require 'formula'

class Tk < Formula
  homepage 'http://www.tcl.tk/'
  url 'http://sourceforge.net/projects/tcl/files/Tcl/8.5.13/tk8.5.13-src.tar.gz'
  version '8.5.13'
  sha1 'a7dc1a979201376d7e7d48ec9280839ebb52a09f'

  # must use a Homebrew-built Tcl since versions must match
  depends_on 'tcl'
  depends_on :x11

  option 'enable-threads', 'Build with multithreading support'
  option 'enable-aqua', 'Build with Aqua support'

  # fix return types (see macports patch)
  def patches
    DATA
  end

  def install
    args = ["--prefix=#{prefix}",
            "--mandir=#{man}",
            "--with-tcl=#{HOMEBREW_PREFIX}/lib"]
    args << "--enable-threads" if build.include? "enable-threads"
    args << "--enable-aqua" if build.include? "enable-aqua"
    args << "--enable-64bit" if MacOS.prefer_64_bit?

    cd 'unix' do
      # so we can find the necessary Tcl headers
      ENV.append 'CFLAGS', "-I#{HOMEBREW_PREFIX}/include"

      system "./configure", *args
      system "make"
      system "make install"

      ln_s bin+'wish8.5', bin+'wish'
    end
  end
end

__END__
diff --git a/macosx/tkMacOSXClipboard.c b/macosx/tkMacOSXClipboard.c
index 7cd9c30..8eedb53 100644
--- a/macosx/tkMacOSXClipboard.c
+++ b/macosx/tkMacOSXClipboard.c
@@ -168,6 +168,7 @@ XSetSelectionOwner(
 	    changeCount = [pb declareTypes:[NSArray array] owner:NSApp];
 	}
     }
+	return Success;
 }
 
 /*
@@ -194,7 +195,6 @@ TkMacOSXSelDeadWindow(
     if (winPtr && winPtr == (TkWindow *)clipboardOwner) {
 	clipboardOwner = NULL;
     }
-    return Success;
 }
 
 /*
diff --git a/macosx/tkMacOSXDraw.c b/macosx/tkMacOSXDraw.c
index 4eb4a88..479166e 100644
--- a/macosx/tkMacOSXDraw.c
+++ b/macosx/tkMacOSXDraw.c
@@ -347,6 +347,7 @@ TkPutImage(
 	TkMacOSXDbgMsg("Invalid destination drawable");
     }
     TkMacOSXRestoreDrawingContext(&dc);
+	return Success;
 }
 
 /*
@@ -744,7 +745,6 @@ DrawCGImage(
     } else {
 	TkMacOSXDbgMsg("Drawing of empty CGImage requested");
     }
-    return Success;
 }
 
 /*

