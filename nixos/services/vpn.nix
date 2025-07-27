{pkgs, ...}: {
  imports = [./mullvad-tailscale.nix];
  services = {
    tailscale.enable = true;
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
    resolved.enable = true;
    mullvad-tailscale.enable = true;
  };

  networking.nftables.enable = true;
}
