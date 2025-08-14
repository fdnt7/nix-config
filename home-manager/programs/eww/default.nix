{...}: {
  programs.eww = {
    enable = false;
    enableFishIntegration = true;
    configDir = ./config;
  };
}
