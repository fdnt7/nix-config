{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.solaar.nixosModules.default ./mullvad-tailscale-split-tunnel.nix];
  services = {
    xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    tailscale.enable = true;
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
    mullvad-tailscale-split-tunnel.enable = true;

    solaar.enable = true;
  };
}
