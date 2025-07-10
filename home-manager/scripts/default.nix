{
  pkgs,
  config,
  ...
}: {
  home.packages = [
    (import ./nix-flake-update.nix {inherit pkgs config;})
    (import ./rebuild.nix {inherit pkgs config;})
    (import ./nix-develop-lyra.nix {inherit pkgs;})
    (import ./vol.nix {inherit pkgs;})
    (import ./getleds.nix {inherit pkgs;})
    (import ./br.nix {inherit pkgs;})
  ];
}
