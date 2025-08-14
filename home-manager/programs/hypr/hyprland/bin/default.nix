{
  inputs,
  pkgs,
}: {
  home.packages = [
    (import ./exec-once.nix {inherit pkgs;})
    (import ./toggle-touchpad.nix {inherit inputs pkgs;})
    (import ./swww-next.nix {inherit pkgs;})
    (import ./lock.nix {inherit pkgs;})
    (import ./bar.nix {inherit pkgs;})
    (import ./set-vol.nix {inherit pkgs;})
    (import ./toggle-mute.nix {inherit pkgs;})
    (import ./showleds.nix {inherit pkgs;})
    (import ./nix-develop-lyra.nix {inherit pkgs;})
  ];
}
