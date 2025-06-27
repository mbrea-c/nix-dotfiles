{ lib, stdenv, fetchzip, openjdk, gradle, makeWrapper, maven, }:

stdenv.mkDerivation rec {
  pname = "kotlin-lsp";
  version = "0.252.17811";
  src = fetchzip {
    url =
      "https://download-cdn.jetbrains.com/kotlin-lsp/${version}/kotlin-${version}.zip";
    hash = "sha256-yplwz3SQzUIYaOoqkvPEy8nQ5p3U/e1O49WNxaE7p9Y=";
    stripRoot = false;
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/bin
    cp -r lib $out/lib
    cp kotlin-lsp.sh $out/bin
    chmod +x $out/bin/kotlin-lsp.sh
  '';

  nativeBuildInputs = [ gradle makeWrapper ];
  buildInputs = [ openjdk gradle ];

  postFixup = ''
    wrapProgram "$out/bin/kotlin-lsp.sh" --set JAVA_HOME ${openjdk} --prefix PATH : ${
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
