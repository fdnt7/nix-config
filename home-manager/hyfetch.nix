{...}: {
  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "demigirl";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.5;
      color_align = {
        mode = "custom";
        custom_colors = {
          "1" = 2;
          "2" = 3;
        };
        fore_back = [];
      };
      backend = "fastfetch";
      pride_month_shown = [];
      pride_month_disable = false;
    };
  };
}
