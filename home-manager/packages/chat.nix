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
  wayland-scanner,
}:
stdenv.mkDerivation rec {
  pname = "chat";
  version = "0.2.3";

  src = fetchurl {
    url = "https://github.com/hypergonial/chat-frontend/releases/download/v${version}/chat-frontend-v${version}-x86_64-unknown-linux-gnu.tar.gz";
    sha256 = "sha256-dGaAEeNfw7WxrruqpnoounYDqdFUbHWGb4ELOzoZzAw=";
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
    wayland-scanner
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
