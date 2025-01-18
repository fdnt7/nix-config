{pkgs, ...}: {
  home.packages = [
    #pkgs.musescore
    (import ./musescore-appimage.nix {inherit pkgs;})
  ];
}
