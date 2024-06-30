{pkgs}: let
  SWWW = "${pkgs.swww}/bin/swww";
in
  pkgs.writeShellScriptBin "swww-next" ''
    BACKGROUND=$(find $XDG_WALLPAPERS_DIR/Pixel/Animated -type f | shuf -n 1)

    ${SWWW} img $BACKGROUND -t grow --transition-step 255 --transition-duration 1 --transition-fps 165 &
  ''
