{config, ...}: {
  imports = [
    ./nix.nix
    ./xdg.nix
    ./qt.nix
    ./theming.nix
    ./gaming.nix
    ./dconf.nix
    ./services
    ./packages
    ./programs
    ./bin
    ./fonts
  ];

  home = {
    username = "fdnt";
    homeDirectory = "/home/fdnt";
    sessionVariables.NH_FLAKE = "${config.home.homeDirectory}/Documents/nix-config";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "25.11";
  };
}
