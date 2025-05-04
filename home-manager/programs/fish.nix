{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.overlays = [
    inputs.nix-your-shell.overlays.default
  ];

  home.packages = [
    pkgs.nix-your-shell
  ];

  catppuccin.fish.enable = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
           fastfetch --config small
           nix-your-shell fish | source
           if test -z "$IN_NIX_SHELL"
      abbr f fastfetch
           else
      abbr f fastfetch --config kangel
           end
    '';
    shellAbbrs = {
      l = "yy";
      #l = "lf";
      s = "sudo";
      py = "python";
      ipy = "ipython";
      rs = "evcxr";
      pg = "psql";
      ht = "htop";
      bt = "btop";
      co = "code";
      pk = "pkill";
      swi = "swww img";
      hpc = "hyprctl clients";
      ze = "zeditor";

      cg = "cargo";
      cga = "cargo add";
      cgc = "cargo check";
      cgcl = "cargo clippy";
      cgl = "cargo clean";
      cgf = "cargo fmt";
      cgr = "cargo run";
      cgu = "cargo update";
      cguu = "cargo upgrade";
      cgd = "cargo doc";
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
      vh = "vim $FLAKE/home-manager/home.nix";
      vcx = "vim $FLAKE/home-manager/xdg.nix";
      vcb = "vim $FLAKE/home-manager/programs/btop.nix";
      vcv = "vim $FLAKE/home-manager/programs/nixvim.nix";
      vcc = "vim $FLAKE/home-manager/programs/vscode.nix";
      vcf = "vim $FLAKE/home-manager/programs/fish.nix";
      vcg = "vim $FLAKE/home-manager/programs/git.nix";
      vck = "vim $FLAKE/home-manager/programs/kitty.nix";
      vca = "vim $FLAKE/home-manager/programs/alacritty.nix";
      vcs = "vim $FLAKE/home-manager/programs/starship.nix";
      vct = "vim $FLAKE/home-manager/programs/fastfetch/fastfetch.nix";
      vco = "vim $FLAKE/home-manager/programs/foot.nix";
      vcy = "vim $FLAKE/home-manager/programs/yazi/yazi.nix";
      vcyi = "vim $FLAKE/home-manager/programs/yazi/init.lua";
      vcyt = "vim $FLAKE/home-manager/programs/yazi/theme.toml";
      vch = "vim $FLAKE/home-manager/programs/hypr/hyprland/hyprland.nix";
      vchc = "vim $FLAKE/home-manager/programs/hypr/hyprcursor/hyprcursor.nix";
      vchse = "vim $FLAKE/home-manager/programs/hypr/hyprland/scripts/exec-once.nix";
      vchi = "vim $FLAKE/home-manager/programs/hypr/hypridle/hypridle.nix";
      vchl = "vim $FLAKE/home-manager/programs/hypr/hyprlock/hyprlock.nix";
      vcl = "vim $FLAKE/home-manager/programs/lf/lf.nix";
      vclc = "vim $FLAKE/home-manager/programs/lf/colours";
      vcli = "vim $FLAKE/home-manager/programs/lf/icons";
      vcw = "vim $FLAKE/home-manager/programs/waybar/waybar.nix";
      vcws = "vim $FLAKE/home-manager/programs/waybar/style.css";
      vcz = "vim $FLAKE/home-manager/programs/zed-editor/zed-editor.nix";

      vc = "vim $FLAKE/nixos/configuration.nix";
      vw = "vim $FLAKE/nixos/hardware-configuration.nix";

      vhH = "vim $FLAKE/home-manager/home.nix && home-manager-switch-flake";
      vcW = "vim $FLAKE/nixos/configuration.nix && nixos-rebuild-flake switch";
      vcT = "vim $FLAKE/nixos/configuration.nix && nixos-rebuild-flake test";
      vwT = "vim $FLAKE/nixos/hardware-configuration.nix && nixos-rebuild-flake test";

      cs = "nixos-rebuild-flake switch";
      ct = "nixos-rebuild-flake test";
      cb = "nixos-rebuild-flake boot";
      u = "nix-flake-update";
      h = "home-manager-switch-flake";
      c = "nh clean all -k 3";
      o = "nix store optimise";

      p = "nh search";
      n = "nix-shell";
      np = "nix-shell -p";
      nd = "nix develop";
      ndi = "nix develop --impure";
      ndidp = "nix develop --impure -c uwsm app -- devenv up";
      "ndize." = "nix develop --impure -c zeditor .";
      nfu = "nix flake update";

      m = "man";
      mh = "man home-configuration.nix";
      mc = "man configuration.nix";
      mn = "man nixvim";

      ds = "devenv shell";
      dp = "uwsm app -- devenv up";

      w = "wget";
      r = "rg";
      t = "time";

      g = "git";
      gm = "git merge";
      gp = "git push";
      gpl = "git pull";
      gr = "git revert";
      gre = "git remote";
      grr = "git reset";
      gc = "git commit";
      gch = "git checkout";
      gl = "git log";
      gd = "git diff";
      gs = "git status";
      gb = "git branch";
      ga = "git add";
      "ga." = "git add .";

      ":q" = "exit";
      ":wq" = "exit";
    };
    shellAliases = {
      ls = "eza -lah --icons --color=always --git --group-directories-first --color-scale";

      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
      #man = "batman"; # bat-extras broken
      evcxr = "irust";
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
    };
    shellInit = ''
      set fish_greeting
      zoxide init fish | source
      #eval (batpipe) # bat-extras broken
    '';
    shellInitLast = "${pkgs.starship}/bin/starship init fish | source";
  };
}
