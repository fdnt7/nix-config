{...}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono nerd Font";
      size = 11;
    };
    shellIntegration = {
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
    settings = {
      background_opacity = "0.67";

      color7 = "#A6ADC8";
      color15 = "#BAC2DE";

      color9 = "#F3AAE2";
      color10 = "#C7FFF2";
      color11 = "#FFFDE6";
      color12 = "#AABDFF";
      color13 = "#FFD6FF";
      color14 = "#B5FFF6";
    };
    theme = "Catppuccin-Mocha";
  };
}
