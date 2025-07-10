{pkgs}: {
  home.packages = [
    (import ./exec-once.nix {inherit pkgs;})
    (import ./toggle-touchpad.nix {inherit pkgs;})
    (import ./swww-next.nix {inherit pkgs;})
    #(import ./lock.nix {inherit inputs pkgs;})
    (import ./lock.nix {inherit pkgs;})
    (import ./open-bar.nix {inherit pkgs;})
    (import ./close-bar.nix {inherit pkgs;})
    (import ./set-vol.nix {inherit pkgs;})
    (import ./toggle-mute.nix {inherit pkgs;})
    (import ./showleds.nix {inherit pkgs;})
  ];
}
