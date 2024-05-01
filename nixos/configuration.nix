# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
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
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

    extraOptions = ''
      use-xdg-base-directories = true
    '';
  };

  networking.hostName = "cuties-only";

  users.users = {
    fdnt = {
      isNormalUser = true;
      description = "Fridella";
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = ["wheel" "networkmanager" "input" "video"];
      shell = pkgs.fish;
    };
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";

  boot = {
    supportedFilesystems = ["ntfs"];
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        useOSProber = true;
      };
    };
  };
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Bangkok";
  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "th_TH.UTF-8";
      LC_IDENTIFICATION = "th_TH.UTF-8";
      LC_MEASUREMENT = "th_TH.UTF-8";
      LC_MONETARY = "th_TH.UTF-8";
      LC_NAME = "th_TH.UTF-8";
      LC_NUMERIC = "th_TH.UTF-8";
      LC_PAPER = "th_TH.UTF-8";
      LC_TELEPHONE = "th_TH.UTF-8";
      LC_TIME = "th_TH.UTF-8";
    };
  };

  services = {
    udev.packages = [pkgs.swayosd];
    xserver = {
      enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    displayManager = {
      enable = true;
      sddm = {
        enable = true;
        wayland = {
          enable = true;
        };
        #theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
      };
    };
    printing.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security = {
    rtkit = {
      enable = true;
    };
    polkit = {
      enable = true;
    };
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  programs = {
    hyprland.enable = true;
    fish.enable = true;
    git.enable = true;
    neovim.enable = true;
    wshowkeys.enable = true;

    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamescope.enable = true;
    gamemode.enable = true;
  };

  environment = {
    sessionVariables = {
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_STATE_HOME = "$HOME/.local/state";
      XDG_CACHE_HOME = "$HOME/.cache";

      HISTFILE = "$XDG_STATE_HOME/bash/history";
      GNUPGHOME = "$XDG_DATA_HOME/gnupg";
      RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
      GTK2_RC_FILES = "$XDG_CONFIG_HOME/gtk-2.0/gtkrc";
      IPYTHONDIR = "$XDG_CONFIG_HOME/ipython";
      WAKATIME_HOME = "$XDG_CONFIG_HOME/wakatime";
      CARGO_HOME = "$XDG_DATA_HOME/cargo";
    };
    variables = {
      EDITOR = "nvim";
    };
    systemPackages = with pkgs; [
      #      libsForQt5.polkit-kde-agent
      lf
      ctpv
      starship
      tree
      home-manager
      #      libsForQt5.qt5.qtquickcontrols2
      #      libsForQt5.qt5.qtgraphicaleffects
      nix-diff
    ];
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      ubuntu_font_family
      tlwg
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
        ];
      })
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["Ubuntu"];
        sansSerif = ["Ubuntu"];
        monospace = ["JetBrainsMono Nerd Font"];
      };
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
  };
}