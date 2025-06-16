{
  description = "Fridella's nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      #url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #hardware.url = "github:NixOS/nixos-hardware/master";

    #nur = {
    #  url = "github:nix-community/NUR";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #stylix.url = "github:danth/stylix";
    catppuccin.url = "github:catppuccin/nix";
    #wezterm.url = "github:wez/wezterm?dir=nix";

    yazi.url = "github:sxyazi/yazi";

    #waybar = {
    #  url = "github:Alexays/Waybar";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    #hyprlock = {
    #  url = "github:hyprwm/hyprlock";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tsutsumi = {
      url = "github:Fuwn/tsutsumi";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      cuties-only = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "fdnt@cuties-only" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        # > Our main home-manager configuration file <
        modules = [./home-manager/home.nix];
      };
    };
  };
}
