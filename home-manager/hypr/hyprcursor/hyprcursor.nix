{pkgs, ...}: {
  home.packages = [pkgs.hyprcursor];

  xdg.dataFile."icons/theme-Kangel".source = ./theme_Kangel;
  wayland.windowManager.hyprland.settings.env = ["HYPRCURSOR_THEME,Kangel" "HYPRCURSOR_SIZE,32"];
}
