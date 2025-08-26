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
    loginShellInit = ''
      if uwsm check may-start
        exec uwsm start hyprland-uwsm.desktop
      end
    '';
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
      #ipy = "ipython";
      #rs = "evcxr";
      pg = "psql";
      ht = "htop";
      bt = "btop";
      #co = "code";
      pk = "pkill";
      sw = "swww";
      #swi = "swww img";
      hpc = "hyprctl clients";
      ze = "zeditor";
      "ze." = "zeditor .";

      cg = "cargo";
      cgn = "cargo new";
      cgi = "cargo init";
      cga = "cargo add";
      cgc = "cargo check";
      cgcl = "cargo clippy";
      cgl = "cargo clean";
      cgf = "cargo fmt";
      cgr = "cargo run";
      cgrr = "cargo run --release";
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
        expansion = "$NH_FLAKE/%";
      };
      ".h" = {
        position = "anywhere";
        setCursor = true;
        expansion = "$NH_FLAKE/home-manager/%";
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
        expansion = "vim $NH_FLAKE/nixos/%";
      };
      "vc." = {
        setCursor = true;
        expansion = "vim $NH_FLAKE/home-manager/%";
      };
      vf = "vim $NH_FLAKE/flake.nix";
      vh = "vim $NH_FLAKE/home-manager/home.nix";
      vcx = "vim $NH_FLAKE/home-manager/xdg.nix";
      vcb = "vim $NH_FLAKE/home-manager/programs/btop.nix";
      vcv = "vim $NH_FLAKE/home-manager/programs/nixvim.nix";
      vcc = "vim $NH_FLAKE/home-manager/programs/vscode.nix";
      vcf = "vim $NH_FLAKE/home-manager/programs/fish.nix";
      vcg = "vim $NH_FLAKE/home-manager/programs/git.nix";
      vck = "vim $NH_FLAKE/home-manager/programs/kitty.nix";
      vca = "vim $NH_FLAKE/home-manager/programs/alacritty.nix";
      vcs = "vim $NH_FLAKE/home-manager/programs/starship.nix";
      vct = "vim $NH_FLAKE/home-manager/programs/fastfetch/default.nix";
      vco = "vim $NH_FLAKE/home-manager/programs/foot.nix";
      vcy = "vim $NH_FLAKE/home-manager/programs/yazi/default.nix";
      vcyi = "vim $NH_FLAKE/home-manager/programs/yazi/init.lua";
      vcyt = "vim $NH_FLAKE/home-manager/programs/yazi/theme.toml";
      vch = "vim $NH_FLAKE/home-manager/programs/hypr/hyprland/default.nix";
      #vchc = "vim $NH_FLAKE/home-manager/programs/hypr/hyprcursor/default.nix";
      vchse = "vim $NH_FLAKE/home-manager/programs/hypr/hyprland/bin/exec-once.nix";
      vchi = "vim $NH_FLAKE/home-manager/programs/hypr/hypridle/default.nix";
      vchl = "vim $NH_FLAKE/home-manager/programs/hypr/hyprlock/default.nix";
      #vcl = "vim $NH_FLAKE/home-manager/programs/lf/default.nix";
      #vclc = "vim $NH_FLAKE/home-manager/programs/lf/colours";
      #vcli = "vim $NH_FLAKE/home-manager/programs/lf/icons";
      #vcw = "vim $NH_FLAKE/home-manager/programs/waybar/default.nix";
      #vcws = "vim $NH_FLAKE/home-manager/programs/waybar/style.css";
      vcz = "vim $NH_FLAKE/home-manager/programs/zed-editor/default.nix";

      vc = "vim $NH_FLAKE/nixos/configuration.nix";
      vw = "vim $NH_FLAKE/nixos/hardware-configuration.nix";

      a = "rebuild";
      u = "nix-flake-update";
      c = "nh clean all -k 3";
      o = "nix store optimise";
      x = "chmod +x";

      p = "nh search";
      n = "nix-shell";
      np = "nix-shell -p";
      nd = "nix develop";
      ndi = "nix develop --no-pure-eval";
      ndideu = "nix develop --no-pure-eval -c devenv up -D";
      "ndize." = "nix develop --no-pure-eval -c zeditor .";
      nfu = "nix flake update";

      m = "man";
      mh = "man home-configuration.nix";
      mc = "man configuration.nix";
      mn = "man nixvim";

      des = "devenv shell";
      deu = "devenv up -D";

      w = "wget";
      r = "rg";
      t = "time";

      g = "git";
      gf = "git fetch";
      gl = "git log";
      gd = "git diff";

      ga = "git add";
      "ga." = "git add .";

      gm = "git merge";
      gms = "git merge --squash";

      gp = "git push";
      gpf = "git push --force-with-lease";
      gpu = "git push -u";
      gpl = "git pull";

      grv = "git revert";
      grs = "git reset";
      grsh = "git reset --hard";
      grm = "git rm";
      grb = "git rebase";
      grmo = "git remote";
      grmog = "git remote get-url";
      grmos = "git remote set-url";
      grmor = "git remote remove";
      grmoa = "git remote add";

      gc = "git commit";
      gca = "git commit --amend";
      gcl = "git clone";
      gh = "git checkout";
      ghm = "git checkout main";

      gs = "git status";
      gst = "git stash";
      gstl = "git stash list";
      gstp = "git stash pop";
      gsh = "git show";
      gsw = "git switch";

      gb = "git branch";
      gbd = "git branch -d";
      gbm = "git branch -m";

      d = "docker";
      dcp = "docker compose";
      dl = "docker logs";
      dp = "docker ps";
      dcpu = "docker compose up -d";
      dcpd = "docker compose down";

      pa = "process-compose attach";
      pd = "process-compose down";

      csp = "codespell";

      ":q" = "exit";
      ":wq" = "exit";
    };
    shellAliases = {
      ls = "eza -lah --icons --color=always --git --group-directories-first --color-scale";

      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
      #man = "batman"; # bat-extras broken
      #evcxr = "irust";
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
      #eval (batpipe) # bat-extras broken
    '';
    shellInitLast = ''
      zoxide init fish | source
      ${pkgs.starship}/bin/starship init fish | source
    '';
  };
}
