{pkgs}: let
  BRIGHTNESSCTL = "${pkgs.brightnessctl}/bin/brightnessctl";
in
  pkgs.writeShellScriptBin "brightness-down" ''
    ${BRIGHTNESSCTL} set 16- &&
    echo "($(${BRIGHTNESSCTL} get)*100)/255" | bc > $XDG_RUNTIME_DIR/wob.sock
  ''
