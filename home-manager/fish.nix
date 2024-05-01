{pkgs, ...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = "fastfetch --config small";
    shellAbbrs = {
      l = "lf";
      s = "sudo";
      f = "fastfetch";
      ff = "fastfetch";
      hf = "hyfetch";
      py = "python";
      rs = "evcxr";
      pg = "psql";
      ht = "htop";
      bt = "btop";
      pk = "pkill";
      swi = "swww img";
      hpc = "hyprctl clients";

      cg = "cargo";
      cgc = "cargo check";
      cgl = "cargo clean";
      cgf = "cargo fmt";
      cgr = "cargo run";
      cgb = "cargo build";
      cgbr = "cargo build --release";
      cgt = "cargo test";
      cgtr = "cargo test --release";

      ".c" = {
        position = "anywhere";
        setCursor = true;
        expansion = "$XDG_CONFIG_HOME/%";
      };
      ".f" = {
        position = "anywhere";
        setCursor = true;
        expansion = "$FLAKE/%";
      };
      ".h" = {
        position = "anywhere";
        setCursor = true;
        expansion = "$FLAKE/home-manager/%";
      };
      ".d" = {
        position = "anywhere";
        setCursor = true;
        expansion = "$XDG_DATA_HOME/%";
      };
      ".s" = {
        position = "anywhere";
        setCursor = true;
        expansion = "/mnt/store/%";
      };

      v = "vim";
      vv = "sudoedit";
      "v." = {
        setCursor = true;
        expansion = "vim $FLAKE/home-manager/%";
      };
      vf = "vim $FLAKE/flake.nix";
      vh = "vim $FLAKE/home-manager/home.nix";
      vhh = "vim $FLAKE/home-manager/home.nix && home-manager-switch-flake";
      vcv = "vim $FLAKE/home-manager/nixvim.nix";
      vcc = "vim $FLAKE/home-manager/vscode.nix";
      vcf = "vim $FLAKE/home-manager/fish.nix";
      vcg = "vim $FLAKE/home-manager/git.nix";
      vck = "vim $FLAKE/home-manager/kitty.nix";
      vca = "vim $FLAKE/home-manager/alacritty.nix";
      vcs = "vim $FLAKE/home-manager/starship.nix";
      vcx = "vim $FLAKE/home-manager/xdg.nix";
      vcff = "vim $FLAKE/home-manager/fastfetch.nix";
      vch = "vim $FLAKE/home-manager/hypr/hyprland/hyprland.nix";
      vchc = "vim $FLAKE/home-manager/hypr/hyprcursor/hyprcursor.nix";
      vchse = "vim $FLAKE/home-manager/hypr/hyprland/scripts/exec-once.nix";
      vchi = "vim $FLAKE/home-manager/hypr/hypridle/hypridle.conf";
      vchl = "vim $FLAKE/home-manager/hypr/hyprlock/hyprlock.conf";
      vcl = "vim $FLAKE/home-manager/lf/lf.nix";
      vclc = "vim $FLAKE/home-manager/lf/colours";
      vcli = "vim $FLAKE/home-manager/lf/icons";
      vcw = "vim $FLAKE/home-manager/waybar/waybar.nix";
      vcws = "vim $FLAKE/home-manager/waybar/style.css";

      vc = "vim $FLAKE/nixos/configuration.nix";
      vw = "vim $FLAKE/nixos/hardware-configuration.nix";
      vcu = "vim $FLAKE/nixos/configuration.nix && nixos-rebuild-flake switch";
      vct = "vim $FLAKE/nixos/configuration.nix && nixos-rebuild-flake test";
      vwu = "vim $FLAKE/nixos/hardware-configuration.nix && nixos-rebuild-flake test";

      a = "nixos-rebuild-flake switch";
      t = "nixos-rebuild-flake test";
      b = "nixos-rebuild-flake boot";
      u = "nix-flake-update";
      h = "home-manager-switch-flake";
      p = "nh search";
      n = "nix-shell -p";

      m = "man";
      mh = "man home-configuration.nix";
      mc = "man configuration.nix";

      ":q" = "exit";
      ":wq" = "exit";
    };
    shellAliases = {
      ls = "eza -lah --icons --color=always --git --group-directories-first --color-scale";

      diff = "colordiff";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
      man = "batman";
      evcxr = "irust";
      python = "ipython";
      #psql = "pgcli";
      df = "df -hPT";
      mount = "mount | column -t";
      tree = "tree -a -I .git";
      cp = "cp -i";
      ln = "ln -i";
      mv = "mv -i";
      rm = "rm -i";
      mkdir = "mkdir -pv";
      du = "dust";
      cat = "bat";
      grep = "rg";
      visudo = "sudoedit /etc/sudoers";

      wget = "wget -c --hsts-file=$XDG_DATA_HOME/wget-hsts";
    };
    shellInit = ''
      set fish_greeting
      zoxide init fish | source
      eval (batpipe)
    '';
    shellInitLast = "${pkgs.starship}/bin/starship init fish | source";
  };
}
