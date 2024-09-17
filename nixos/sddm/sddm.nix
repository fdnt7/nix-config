{pkgs, ...}: {
  environment.systemPackages = [pkgs.sddm-sugar-dark pkgs.qt5.qtgraphicaleffects];
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    #theme = "${import ./theme.nix {inherit pkgs;}}";
    theme = "sugar-dark";
  };
}
