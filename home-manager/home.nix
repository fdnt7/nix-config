{config, ...}: {
  imports = [
    ./nix.nix
    ./xdg.nix
    ./qt.nix
    ./theming.nix
    ./gaming.nix
    ./services.nix
    ./packages.nix
    ./dconf.nix

    ./programs/programs.nix
    ./scripts/scripts.nix
    ./fonts/fonts.nix
  ];

  home = {
    username = "fdnt";
    homeDirectory = "/home/fdnt";
    sessionVariables.FLAKE = "${config.home.homeDirectory}/Documents/nix-config";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "25.05";
  };
}
