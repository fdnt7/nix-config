{pkgs, ...}: {
  home.packages = [pkgs.fastfetch];

  xdg = {
    configFile."fastfetch/config.jsonc".source = ./config.jsonc;
    dataFile = {
      "fastfetch/presets".source = ./presets;
      "fastfetch/logos".source = ./logos;
    };
  };
}
