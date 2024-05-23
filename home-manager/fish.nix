{pkgs, ...}: {
  programs.fish = {
    enable = true;
    catppuccin.enable = true;
    interactiveShellInit = "fastfetch --config small";
    shellAbbrs = {
      l = "yy";
      s = "sudo";
      f = "fastfetch";
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
        expansion = "vim $FLAKE/nixos/%";
      };
      "vc." = {
        setCursor = true;
        expansion = "vim $FLAKE/home-manager/%";
      };
      vf = "vim $FLAKE/flake.nix";
      vc = "vim $FLAKE/home-manager/home.nix";
      vcb = "vim $FLAKE/home-manager/btop.nix";
      vcv = "vim $FLAKE/home-manager/nixvim.nix";
      vcc = "vim $FLAKE/home-manager/vscode.nix";
      vcf = "vim $FLAKE/home-manager/fish.nix";
      vcg = "vim $FLAKE/home-manager/git.nix";
      vck = "vim $FLAKE/home-manager/kitty.nix";
      vca = "vim $FLAKE/home-manager/alacritty.nix";
      vcs = "vim $FLAKE/home-manager/starship.nix";
      vcx = "vim $FLAKE/home-manager/xdg.nix";
      vct = "vim $FLAKE/home-manager/fastfetch/fastfetch.nix";
      vco = "vim $FLAKE/home-manager/foot.nix";
      vcy = "vim $FLAKE/home-manager/yazi/yazi.nix";
      vch = "vim $FLAKE/home-manager/hypr/hyprland/hyprland.nix";
      vchc = "vim $FLAKE/home-manager/hypr/hyprcursor/hyprcursor.nix";
      vchse = "vim $FLAKE/home-manager/hypr/hyprland/scripts/exec-once.nix";
      vchi = "vim $FLAKE/home-manager/hypr/hypridle/hypridle.nix";
      vchl = "vim $FLAKE/home-manager/hypr/hyprlock/hyprlock.nix";
      vcl = "vim $FLAKE/home-manager/lf/lf.nix";
      vclc = "vim $FLAKE/home-manager/lf/colours";
      vcli = "vim $FLAKE/home-manager/lf/icons";
      vcw = "vim $FLAKE/home-manager/waybar/waybar.nix";
      vcws = "vim $FLAKE/home-manager/waybar/style.css";

      vn = "vim $FLAKE/nixos/configuration.nix";
      vh = "vim $FLAKE/nixos/hardware-configuration.nix";

      vcH = "vim $FLAKE/home-manager/home.nix && home-manager-switch-flake";
      vnW = "vim $FLAKE/nixos/configuration.nix && nixos-rebuild-flake switch";
      vnT = "vim $FLAKE/nixos/configuration.nix && nixos-rebuild-flake test";
      vhT = "vim $FLAKE/nixos/hardware-configuration.nix && nixos-rebuild-flake test";

      w = "nixos-rebuild-flake switch";
      t = "nixos-rebuild-flake test";
      b = "nixos-rebuild-flake boot";
      u = "nix-flake-update";
      h = "home-manager-switch-flake";

      p = "nh search";
      n = "nix-shell --run fish";
      np = "nix-shell --run fish -p";
      nd = "nix develop";

      m = "man";
      mh = "man home-configuration.nix";
      mc = "man configuration.nix";
      mn = "man nixvim";

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
    functions = {
      yy = {
        body = ''
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          yazi $argv --cwd-file="$tmp"
          if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
          	cd -- "$cwd"
          end
          rm -f -- "$tmp"
        '';
      };
    };
    shellInit = ''
      set fish_greeting
      zoxide init fish | source
      eval (batpipe)
    '';
    shellInitLast = "${pkgs.starship}/bin/starship init fish | source";
  };
}
