{
  stdenv,
  fetchurl,
  makeWrapper,
  steam-run,
  lib,
}:

stdenv.mkDerivation rec {
  pname = "classicube";
  version = "1.3.8";

  src = fetchurl {
    url = "https://cdn.classicube.net/client/release/nix64/ClassiCube.tar.gz";
    hash = "sha256-I4ZDdqZh1wbvxRhfg4j79e/hILe6mGxeW55W+z+uMlE=";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    cat > $out/bin/classicube << 'WRAPPER_EOF'
#!/usr/bin/env bash
GAME_DIR="$HOME/.classicube"
STORE_DIR="@out@/share/classicube"

# Copy game files if not present or if store version is newer
if [ ! -f "$GAME_DIR/ClassiCube" ]; then
    mkdir -p "$GAME_DIR"
    cp -r "$STORE_DIR"/* "$GAME_DIR"/
    chmod -R u+w "$GAME_DIR"
fi

cd "$GAME_DIR"
exec STEAM_RUN/bin/steam-run ./ClassiCube "$@"
WRAPPER_EOF

    substituteInPlace $out/bin/classicube \
      --subst-var out \
      --replace STEAM_RUN ${steam-run}

    mkdir -p $out/share/classicube
    cp -r * $out/share/classicube/

    chmod +x $out/bin/classicube

    runHook postInstall
  '';

  meta = with lib; {
    description = "A custom Minecraft Classic compatible client (binary wrapper)";
    homepage = "https://www.classicube.net/";
    license = licenses.bsd3;
    platforms = [ "x86_64-linux" ];
    mainProgram = "classicube";
  };
}
