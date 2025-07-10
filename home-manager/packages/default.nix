{pkgs, ...}: let
  with_pkgs = with pkgs; [
    nh
    nix-output-monitor
    nvd
    #devenv
    alejandra

    #discord-screenaudio

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

    git-credential-manager # for git.hypergonial.com
    gimp3
    #kdePackages.dolphin

    #(pkgs.callPackage ./packages/runapp.nix {})
    #(pkgs.callPackage ./packages/chat.nix {})
    #(pkgs.callPackage ./packages/muse-sounds-manager-2.0.3.659.nix {})
    musescore
    #(import ./packages/musescore-appimage.nix {inherit pkgs;})
    wireshark
    socat # for hyprland ipc
    tutanota-desktop
  ];
in {
  home.packages =
    with_pkgs
    ++ [
    ];
}
