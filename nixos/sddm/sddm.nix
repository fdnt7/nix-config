{pkgs, ...}: {
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
    };
    # theme = "${import ./theme.nix { inherit pkgs; }}";
    theme = "breeze";
  };
}
