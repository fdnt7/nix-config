{
  pkgs,
  config,
  ...
}: {
  home.packages = [
    (import ./nix-flake-update.nix {inherit pkgs config;})
    (import ./rebuild.nix {inherit pkgs config;})
    (import ./vol.nix {inherit pkgs;})
    (import ./getleds.nix {inherit pkgs;})
    (import ./br.nix {inherit pkgs;})
    (import ./qr.nix {inherit pkgs;})
    (import ./vpn.nix {inherit pkgs;})
  ];
}
