{inputs, ...}: {
  imports = [inputs.solaar.nixosModules.default ./vpn.nix];
  services = {
    xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    solaar.enable = true;
  };
}
