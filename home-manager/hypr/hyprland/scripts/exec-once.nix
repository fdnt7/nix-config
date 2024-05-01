{pkgs}: let
  HYPRIDLE = "${pkgs.hypridle}/bin/hypridle";
  SWWW = "${pkgs.swww}/bin/swww";
  SWWW-DAEMON = "${pkgs.swww}/bin/swww-daemon";
in
  pkgs.writeShellScriptBin "exec-once" ''
    BACKGROUND=$(find $XDG_WALLPAPERS_DIR/Pixel/Animated -type f | shuf -n 1)

    ${HYPRIDLE} &
    ${SWWW-DAEMON} &
    ${SWWW} img $BACKGROUND -t grow --transition-step 255 --transition-duration 1 --transition-fps 165 &
  ''
