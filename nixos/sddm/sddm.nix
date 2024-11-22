{pkgs, ...}: {
  services = {
    #desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      wayland.enable = true;
      theme = "breeze";
      #theme = "${import ./theme.nix {inherit pkgs;}}";
      #extraPackages = with pkgs.kdePackages; [breeze breeze-icons breeze-gtk qqc2-breeze-style breeze.qt5];
    };
  };
}
