{pkgs, ...}: {
  programs.bat = {
    enable = true;
    catppuccin.enable = true;
    extraPackages = with pkgs.bat-extras; [batdiff batman batgrep batwatch batpipe];
  };
}
