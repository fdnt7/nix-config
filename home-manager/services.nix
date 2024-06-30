{pkgs, ...}: {
  services = {
    playerctld.enable = false;
    swayosd.enable = true;
    network-manager-applet.enable = false;
    gpg-agent = {
      enable = true;
      enableFishIntegration = true;
      pinentryPackage = pkgs.pinentry-qt;
    };
    ssh-agent.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
