{
  pkgs,
  config,
  ...
}: {
  home.packages = [
    (import ./home-manager-switch-flake.nix {inherit pkgs config;})
    (import ./nix-flake-update.nix {inherit pkgs config;})
    (import ./nixos-rebuild-flake.nix {inherit pkgs config;})
    (import ./nix-develop-lyra.nix {inherit pkgs;})
    (import ./vol.nix {inherit pkgs;})
    (import ./getleds.nix {inherit pkgs;})
  ];
}
