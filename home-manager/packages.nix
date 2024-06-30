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
    jq
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
    musescore
    audacity

    xdg-ninja
    python311Packages.ipython
    colordiff
    ripgrep
    du-dust
    python3
    brightnessctl
    zoxide
    wget
    qt5ct
    catppuccin-kvantum
    xwaylandvideobridge
    oculante
    swww
    kitty-img
    brave
    vivaldi
    zed-editor
    sweet-nova
    bc
    hyprpicker
    upscayl
    pinta
    networkmanagerapplet

    #inputs.muse-sounds-manager.packages.${pkgs.system}.muse-sounds-manager
  ];
}
