{pkgs, ...}: {
  services = {
    udev.packages = [pkgs.swayosd];
    xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    #cloudflare-warp.enable = true;
    tailscale.enable = true;
  };
}
