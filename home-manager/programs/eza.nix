{pkgs, ...}: let
  themes = pkgs.fetchFromGitHub {
    owner = "eza-community";
    repo = "eza-themes";
    rev = "302f4783dcd84a8221f1da8223d1ea0885fd26e3";
    hash = "sha256-dd9KBb3Upg+x/4ImQwSwKWtDHyfk/29zLkmrVgHVsh0=";
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
