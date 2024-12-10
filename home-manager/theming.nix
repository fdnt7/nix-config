{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.catppuccin.homeManagerModules.catppuccin];
  catppuccin.flavor = "mocha";

  xdg = {
    configFile = {
      "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
        General.theme = "Sweet";
      };
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    #package = pkgs.bibata-cursors;
    #name = "Bibata-Modern-Classic";
    package = pkgs.posy-cursors;
    name = "Posy_Cursor";
    size = 20;
  };

  gtk = {
    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    };
    enable = true;
    theme = {
      package = pkgs.sweet;
      name = "Sweet-Dark";
    };
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
      name = "Papirus-Dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      name = "kvantum";
    };
  };
}
