{...}: {
  catppuccin.cava = {
    enable = true;
    transparent = true;
  };
  programs.cava = {
    enable = true;
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
