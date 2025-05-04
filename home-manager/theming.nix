{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.catppuccin.homeModules.catppuccin];
  catppuccin.flavor = "mocha";

  dconf.settings = {
    "org/freedesktop/appearance" = {
      color-scheme = 1;
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    #package = pkgs.posy-cursors;
    #name = "Posy_Cursor";
    size = 20;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      #package = pkgs.catppuccin-papirus-folders.override {
      #  flavor = "mocha";
      #  accent = "lavender";
      #};
      name = "Papirus-Dark";
    };
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };
}
