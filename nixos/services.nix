{pkgs, ...}: {
  services = {
    udev.packages = [pkgs.swayosd];
    xserver = {
      enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    printing.enable = true;
    cloudflare-warp.enable = true;
  };
}
