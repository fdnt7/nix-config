{
  stdenv,
  lib,
  fetchurl,
  autoPatchelfHook,
  jdk17,
  libGL,
  xorg,
  fontconfig,
  zlib,
  alsa-lib,
  freetype,
  glib,
  dbus,
}:
stdenv.mkDerivation rec {
  pname = "chat";
  version = "0.1.1";

  src = fetchurl {
    url = "https://github.com/hypergonial/chat-frontend/releases/download/v${version}/chat-frontend-v${version}-x86_64-unknown-linux-gnu.tar.gz";
    sha256 = "sha256-W516+8Fvjb1JGPEPkgF75HnE9EGzjRk8wsbg2Tbbuwo=";
  };

  nativeBuildInputs = [autoPatchelfHook];
  buildInputs = [
    jdk17
    libGL
    xorg.libX11
    fontconfig
    xorg.libXext
    zlib
    alsa-lib
    xorg.libXrender
    xorg.libXtst
    xorg.libXi
    freetype
    dbus
    glib
  ];

  installPhase = ''
    mkdir -p $out/bin $out/lib
    cp -r bin/* $out/bin/
    cp -r lib/* $out/lib/
    chmod +x $out/bin/com.hypergonial.chat
    ln -s $out/bin/com.hypergonial.chat $out/bin/chat
  '';

  meta = with lib; {
    description = "Compose Multiplatform frontend for Chat";
    platforms = platforms.linux;
  };
}
