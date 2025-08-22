{ lib, stdenv, fetchzip, openjdk, gradle, makeWrapper, maven, }:

stdenv.mkDerivation rec {
  pname = "kotlin-lsp";
  version = "0.253.10629";
  src = fetchzip {
    url =
      "https://download-cdn.jetbrains.com/kotlin-lsp/${version}/kotlin-${version}.zip";
    hash = "sha256-LCLGo3Q8/4TYI7z50UdXAbtPNgzFYtmUY/kzo2JCln0=";
    stripRoot = false;
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/bin
    cp -r lib/* $out/lib
    cat >$out/bin/kotlin-lsp <<EOF
    #!/usr/bin/env bash

    DIR=$out

    if [ ! -d "\$DIR/lib" ]; then
        echo >&2 -e "The 'lib' directory does not exist."
        exit 1
    fi

    JAVA_BIN="java"
    if [ -n "\$JAVA_HOME" ]; then
        JAVA_BIN="\$JAVA_HOME/bin/java"
        if [ ! -x "\$JAVA_BIN" ]; then
            echo >&2 -e "'java' should be on the PATH or JAVA_HOME must point to a valid JDK installation"
            exit 1
        fi
    fi

    "\$JAVA_BIN" \\
        --add-opens java.base/java.io=ALL-UNNAMED \\
        --add-opens java.base/java.lang=ALL-UNNAMED \\
        --add-opens java.base/java.lang.ref=ALL-UNNAMED \\
        --add-opens java.base/java.lang.reflect=ALL-UNNAMED \\
        --add-opens java.base/java.net=ALL-UNNAMED \\
        --add-opens java.base/java.nio=ALL-UNNAMED \\
        --add-opens java.base/java.nio.charset=ALL-UNNAMED \\
        --add-opens java.base/java.text=ALL-UNNAMED \\
        --add-opens java.base/java.time=ALL-UNNAMED \\
        --add-opens java.base/java.util=ALL-UNNAMED \\
        --add-opens java.base/java.util.concurrent=ALL-UNNAMED \\
        --add-opens java.base/java.util.concurrent.atomic=ALL-UNNAMED \\
        --add-opens java.base/java.util.concurrent.locks=ALL-UNNAMED \\
        --add-opens java.base/jdk.internal.vm=ALL-UNNAMED \\
        --add-opens java.base/sun.net.dns=ALL-UNNAMED \\
        --add-opens java.base/sun.nio.ch=ALL-UNNAMED \\
        --add-opens java.base/sun.nio.fs=ALL-UNNAMED \\
        --add-opens java.base/sun.security.ssl=ALL-UNNAMED \\
        --add-opens java.base/sun.security.util=ALL-UNNAMED \\
        --add-opens java.desktop/com.apple.eawt=ALL-UNNAMED \\
        --add-opens java.desktop/com.apple.eawt.event=ALL-UNNAMED \\
        --add-opens java.desktop/com.apple.laf=ALL-UNNAMED \\
        --add-opens java.desktop/com.sun.java.swing=ALL-UNNAMED \\
        --add-opens java.desktop/com.sun.java.swing.plaf.gtk=ALL-UNNAMED \\
        --add-opens java.desktop/java.awt=ALL-UNNAMED \\
        --add-opens java.desktop/java.awt.dnd.peer=ALL-UNNAMED \\
        --add-opens java.desktop/java.awt.event=ALL-UNNAMED \\
        --add-opens java.desktop/java.awt.font=ALL-UNNAMED \\
        --add-opens java.desktop/java.awt.image=ALL-UNNAMED \\
        --add-opens java.desktop/java.awt.peer=ALL-UNNAMED \\
        --add-opens java.desktop/javax.swing=ALL-UNNAMED \\
        --add-opens java.desktop/javax.swing.plaf.basic=ALL-UNNAMED \\
        --add-opens java.desktop/javax.swing.text=ALL-UNNAMED \\
        --add-opens java.desktop/javax.swing.text.html=ALL-UNNAMED \\
        --add-opens java.desktop/sun.awt=ALL-UNNAMED \\
        --add-opens java.desktop/sun.awt.X11=ALL-UNNAMED \\
        --add-opens java.desktop/sun.awt.datatransfer=ALL-UNNAMED \\
        --add-opens java.desktop/sun.awt.image=ALL-UNNAMED \\
        --add-opens java.desktop/sun.awt.windows=ALL-UNNAMED \\
        --add-opens java.desktop/sun.font=ALL-UNNAMED \\
        --add-opens java.desktop/sun.java2d=ALL-UNNAMED \\
        --add-opens java.desktop/sun.lwawt=ALL-UNNAMED \\
        --add-opens java.desktop/sun.lwawt.macosx=ALL-UNNAMED \\
        --add-opens java.desktop/sun.swing=ALL-UNNAMED \\
        --add-opens java.management/sun.management=ALL-UNNAMED \\
        --add-opens jdk.attach/sun.tools.attach=ALL-UNNAMED \\
        --add-opens jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED \\
        --add-opens jdk.internal.jvmstat/sun.jvmstat.monitor=ALL-UNNAMED \\
        --add-opens jdk.jdi/com.sun.tools.jdi=ALL-UNNAMED \\
        -cp "\$DIR/lib/*" com.jetbrains.ls.kotlinLsp.KotlinLspServerKt "\$@"
    EOF
    chmod +x $out/bin/kotlin-lsp
  '';

  nativeBuildInputs = [ gradle makeWrapper ];
  buildInputs = [ openjdk gradle ];

  postFixup = ''
    wrapProgram "$out/bin/kotlin-lsp" --set JAVA_HOME ${openjdk} --prefix PATH : ${
      lib.strings.makeBinPath [ openjdk maven ]
    }
  '';

  meta = {
    description = "Kotlin LSP (JetBrains)";
    longDescription = ''
      About Kotlin code completion, linting and more for any editor/IDE
      using the Language Server Protocol Topics.'';
    maintainers = with lib.maintainers; [ vtuan10 ];
    homepage = "https://github.com/Kotlin/kotlin-lsp";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    sourceProvenance = [ lib.sourceTypes.binaryBytecode ];
  };
}
