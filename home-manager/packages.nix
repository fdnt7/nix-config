{pkgs, ...}: {
  home.packages = with pkgs; [
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

    libsForQt5.dolphin
    libsForQt5.kdegraphics-thumbnailers
    libsForQt5.kimageformats
    libheif
    resvg
    libsForQt5.ffmpegthumbs
    nufraw-thumbnailer
    taglib
    libsForQt5.kio-extras

    pavucontrol
    playerctl
    jamesdsp
    audacity

    xdg-ninja
    #python311Packages.ipython
    #python3
    ripgrep
    du-dust
    brightnessctl
    zoxide
    wget
    libsForQt5.qt5ct
    catppuccin-kvantum
    xwaylandvideobridge
    oculante
    swww
    kitty-img
    brave
    zed-editor
    #(zed-editor.fhsWithPackages (pkgs: [pkgs.zlib pkgs.pkg-config pkgs.openssl]))
    sweet-nova
    bc
    hyprpicker
    upscayl
    pinta
    networkmanagerapplet
    muse-sounds-manager
  ];
}
