{pkgs, ...}: let
  themes = pkgs.fetchFromGitHub {
    owner = "eza-community";
    repo = "eza-themes";
    rev = "17095bff4792eecd7f4f1ed8301b15000331c906";
    hash = "sha256-2WTbCQlhwMo5cOn3KwtNiIst0tNfASfZnPNsNBs+gcU=";
  };
in {
  xdg.configFile."eza/theme.yml".source = "${themes}/themes/catppuccin.yml";

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
  };
}
