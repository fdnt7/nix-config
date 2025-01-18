{...}: {
  catppuccin.bat.enable = true;
  programs.bat = {
    enable = true;
    #extraPackages = with pkgs.bat-extras; [
    #  batdiff
    #  batman
    #  batgrep
    #  batwatch
    #  batpipe
    #]; # bat-extras broken
  };
}
