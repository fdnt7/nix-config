{...}: {
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true; # recommended for most users
      xwayland.enable = true; # Xwayland can be disabled.
      #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    fish.enable = true;
    git.enable = true;
    neovim.enable = true;
    wshowkeys.enable = true;

    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamescope.enable = true;
    gamemode.enable = true;
  };
}
