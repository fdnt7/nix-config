# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  config,
  pkgs,
  ...
}: let
  genericPackages = with pkgs; [
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
  ];
in {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    ./xdg.nix
    ./theming.nix

    ./git.nix
    ./cava.nix
    ./btop.nix
    ./eza.nix
    ./rofi.nix
    ./starship.nix
    ./fish.nix
    ./zsh.nix
    ./kitty.nix
    ./alacritty.nix
    ./spicetify.nix
    ./gaming.nix
    ./nixvim.nix
    ./vscode.nix
    ./bat.nix
    ./fd.nix
    ./firefox.nix
    ./foot.nix
    ./gpg.nix
    ./htop.nix
    ./mpv.nix
    ./wezterm.nix
    ./obs.nix
    ./yazi/yazi.nix
    ./fastfetch/fastfetch.nix
    ./waybar/waybar.nix
    ./swaync/swaync.nix
    ./lf/lf.nix
    ./fonts/fonts.nix
    ./hypr/hyprland/hyprland.nix
    ./hypr/hyprlock/hyprlock.nix
    ./hypr/hypridle/hypridle.nix
    #./hypr/hyprcursor/hyprcursor.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "fdnt";
    homeDirectory = "/home/fdnt";
    sessionVariables = {
      FLAKE = "${config.home.homeDirectory}/Documents/nix-config";
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.11";
    # Add stuff for your user as you see fit:
    packages =
      [
        (import ../scripts/home-manager-switch-flake.nix {inherit pkgs config;})
        (import ../scripts/nix-flake-update.nix {inherit pkgs config;})
        (import ../scripts/nixos-rebuild-flake.nix {inherit pkgs config;})

        inputs.muse-sounds-manager.packages.${pkgs.system}.muse-sounds-manager
      ]
      ++ genericPackages;
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  services = {
    playerctld.enable = false;
    swayosd.enable = true;
    network-manager-applet.enable = false;
    gpg-agent = {
      enable = true;
      enableFishIntegration = true;
      pinentryPackage = pkgs.pinentry-qt;
    };
    ssh-agent.enable = true;
  };
}
