{...}: {
  programs.cava = {
    enable = true;
    catppuccin = {
      enable = true;
      transparent = true;
    };
    settings = {
      general = {
        framerate = 165;
      };
      smoothing = {
        monstercat = 1;
      };
    };
  };
}
