{pkgs}: let
  SWWW = "${pkgs.swww}/bin/swww";
in
  pkgs.writeShellScriptBin "swww-next" ''
    BACKGROUND=$(find $XDG_WALLPAPERS_DIR/Pixel/Animated -type f | shuf -n 1)
    BACKGROUND_LN=$XDG_STATE_HOME/swww-background
    ln -sfv $BACKGROUND $BACKGROUND_LN

    ${SWWW} img $BACKGROUND_LN -f Nearest -t grow --transition-step 255 --transition-duration 1 --transition-fps 165 &
  ''
