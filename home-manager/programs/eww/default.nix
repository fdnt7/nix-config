{...}: {
  programs.eww = {
    enable = true;
    enableFishIntegration = true;
    configDir = ./config;
  };
}
