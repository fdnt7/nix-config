# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{...}: {
  # You can import other NixOS modules here
  imports = [
    # You can also split up your configuration and import pieces of it here:
    # ./stylix.nix

    # Import your generated (nixos-generate-config) hardware configuration

    ./hardware-configuration.nix

    ./boot.nix
    ./nix.nix
    ./fonts
    ./sound.nix
    ./environment.nix
    ./networking.nix
    ./users.nix
    ./locale.nix
    ./programs.nix
    ./security.nix
    ./virtualisation
    ./sddm
    ./services
    ./xdg.nix
    ./bluetooth.nix

    ./home-manager.nix
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";
}
