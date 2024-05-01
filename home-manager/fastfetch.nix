{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.fastfetch];

  xdg.dataFile = {
    "fastfetch/presets".source = ./fastfetch/presets;
    "fastfetch/logos".source = ./fastfetch/logos;
  };
}
