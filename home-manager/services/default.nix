{pkgs, ...}: {
  imports = [./battery-notifier.nix];

  services = {
    playerctld.enable = false;
    network-manager-applet.enable = false;
    gpg-agent = {
      enable = true;
      enableFishIntegration = true;
      pinentry.package = pkgs.pinentry-qt;
    };
    ssh-agent.enable = true;
    trayscale.enable = true;
    blueman-applet.enable = true;

    battery-notifier.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
