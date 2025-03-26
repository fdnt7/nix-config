{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "alacritty";
    plugins = [pkgs.rofimoji pkgs.rofi-calc pkgs.rofi-power-menu];
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        background-color = mkLiteral "Black";
        border-color = mkLiteral "White";
        text-color = mkLiteral "White";
        font = "JetBrainsMono Nerd Font 9";
      };
      "window" = {
        anchor = mkLiteral "south";
        location = mkLiteral "south";
        width = mkLiteral "100%";
        padding = mkLiteral "4px";
        children = map mkLiteral ["horibox"];
      };
      "horibox" = {
        orientation = mkLiteral "horizontal";
        children = map mkLiteral ["prompt" "entry" "listview"];
      };
      "listview" = {
        layout = mkLiteral "horizontal";
        spacing = mkLiteral "5px";
        lines = 100;
      };
      entry = {
        expand = false;
        width = mkLiteral "10em";
      };
      element = {
        padding = mkLiteral "0px 2px";
      };
      "element selected" = {
        background-color = mkLiteral "#332349";
      };

      "element-text, element-icon" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
    };
  };
}
