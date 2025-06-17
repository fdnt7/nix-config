{pkgs, ...}: let
  with_pkgs = with pkgs; [
    nh
    nix-output-monitor
    nvd
    devenv
    alejandra

    discord
    discord-canary
    discord-screenaudio
    vesktop

    grim
    slurp
    wl-clipboard
    libnotify
    grimblast

    libheif
    resvg
    nufraw-thumbnailer
    taglib

    pavucontrol
    playerctl
    jamesdsp
    audacity

    xdg-ninja
    ripgrep
    du-dust
    brightnessctl
    zoxide
    wget
    oculante
    swww
    kitty-img
    brave
    bc
    hyprpicker
    upscayl
    pinta
    networkmanagerapplet
    xournalpp
    libreoffice-qt-fresh

    git-credential-manager
    gimp3
    #kdePackages.dolphin

    (pkgs.callPackage ./packages/runapp.nix {})
    #(pkgs.callPackage ./packages/chat.nix {})
    (pkgs.callPackage ./packages/muse-sounds-manager-2.0.3.659.nix {})
    (import ./packages/musescore-appimage.nix {inherit pkgs;})
  ];
in {
  home.packages =
    with_pkgs
    ++ [
    ];
}
