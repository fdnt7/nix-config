{...}: {
  programs.fastfetch = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile ./config.jsonc);
  };

  xdg = {
    dataFile = {
      "fastfetch/presets".source = ./presets;
      "fastfetch/logos".source = ./logos;
    };
  };
}
