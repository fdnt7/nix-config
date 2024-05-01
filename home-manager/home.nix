# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    ./git.nix
    ./cava.nix
    ./btop.nix
    ./eza.nix
    ./rofi.nix
    ./starship.nix
    ./fish.nix
    ./kitty.nix
    ./alacritty.nix
    ./spicetify.nix
    ./hyfetch.nix
    ./gaming.nix
    ./nixvim.nix
    ./vscode.nix
    ./fastfetch.nix
    ./hypr/hyprland/hyprland.nix
    ./hypr/hyprlock/hyprlock.nix
    ./hypr/hypridle/hypridle.nix
    #./hypr/hyprcursor/hyprcursor.nix
    ./waybar/waybar.nix
    ./swaync/swaync.nix
    ./lf/lf.nix

    ./xdg.nix
    ./theming.nix
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
    packages = with pkgs; [
      (import ../scripts/home-manager-switch-flake.nix {inherit pkgs config;})
      (import ../scripts/nix-flake-update.nix {inherit pkgs config;})
      (import ../scripts/nixos-rebuild-flake.nix {inherit pkgs config;})
      (nerdfonts.override {fonts = ["JetBrainsMono"];})

      inputs.muse-sounds-manager.packages.x86_64-linux.muse-sounds-manager

      discord
      vesktop

      sweet-nova
      alejandra
      bc

      hyprpicker

      grim
      slurp
      wl-clipboard
      jq
      libnotify
      grimblast

      swww
      kitty-img

      brave

      zed-editor

      libsForQt5.dolphin
      libsForQt5.kdegraphics-thumbnailers
      libsForQt5.kimageformats
      libheif
      resvg
      libsForQt5.ffmpegthumbs
      nufraw-thumbnailer
      taglib
      libsForQt5.kio-extras

      xdg-ninja
      python311Packages.ipython
      colordiff
      ripgrep
      du-dust
      bat
      rustup
      python3
      pavucontrol
      brightnessctl
      bat-extras.batman
      bat-extras.batpipe
      zoxide
      wget
      qt5ct
      musescore
      catppuccin-kvantum
      xwaylandvideobridge
      playerctl
      oculante

      nh
      nix-output-monitor
      nvd
    ];
  };

  # Enable home-manager and git
  programs = {
    home-manager.enable = true;

    htop.enable = true;
    fd.enable = true;
    firefox.enable = true;
    gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  services = {
    playerctld.enable = false;
    swayosd.enable = true;
    network-manager-applet.enable = true;
    gpg-agent = {
      enable = true;
      enableFishIntegration = true;
      pinentryPackage = pkgs.pinentry-curses;
    };
  };

  fonts.fontconfig.enable = true;
}
