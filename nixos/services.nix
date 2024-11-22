{pkgs, ...}: {
  services = {
    udev.packages = [pkgs.swayosd];
    xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    printing.enable = true;
    cloudflare-warp.enable = true;
  };
}
