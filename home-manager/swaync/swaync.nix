{pkgs, ...}: {
  home.packages = [pkgs.swaynotificationcenter];

  xdg.configFile = {
    "swaync/config.json".source = ./config.json;
    "swaync/style.css".source = ./style.css;
  };
}
