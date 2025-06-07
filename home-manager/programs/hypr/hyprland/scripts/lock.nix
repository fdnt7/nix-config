{
  #inputs,
  pkgs,
}: let
  #HYPRLOCK = "${inputs.hyprlock.packages.${pkgs.system}.default}/bin/hyprlock";
  HYPRLOCK = "${pkgs.hyprlock}/bin/hyprlock";
in
  pkgs.writeShellScriptBin "lock" ''
    BACKGROUND=$(find $XDG_WALLPAPERS_DIR/Pixel -maxdepth 1 -type f | shuf -n 1)
    ln -sfv $BACKGROUND $XDG_STATE_HOME/hyprlock-background

    ${HYPRLOCK}
  ''
