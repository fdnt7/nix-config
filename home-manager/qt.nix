{
  pkgs,
  #inputs,
  ...
}: let
  variant = "mocha";
  accent = "lavender";
  kvantumThemePackage = pkgs.catppuccin-kvantum.override {
    inherit variant accent;
  };
in {
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  #home.packages = [pkgs.catppuccin-qt5ct];
  #qt = {
  #  enable = true;
  #  style.package = [
  #    inputs.lightly.packages.${pkgs.system}.darkly-qt5
  #    inputs.lightly.packages.${pkgs.system}.darkly-qt6
  #  ];
  #  platformTheme.name = "qtct";
  #};

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=catppuccin-${variant}-${accent}
    '';

    # The important bit is here, links the theme directory from the package to a directory under `~/.config`
    # where Kvantum should find it.
    "Kvantum/catppuccin-${variant}-${accent}".source = "${kvantumThemePackage}/share/Kvantum/catppuccin-${variant}-${accent}";
  };
}
