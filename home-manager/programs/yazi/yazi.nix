{
  inputs,
  pkgs,
  ...
}: let
  plugs = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "aeca767ec27bfbea66873d667a729791de18f364";
    hash = "sha256-QkjXl8lGeqFgL2FGTs63xW0/hbZEpIyBCWnkdCgcv5s=";
  };

  exifaudio = pkgs.fetchFromGitHub {
    owner = "Sonico98";
    repo = "exifaudio.yazi";
    rev = "e766cd273246612fe71fc18d2126619a41273c32";
    hash = "sha256-aniuY14pXcoaW6YkUwt7hTl9mWjl5HoOPhHkuY4ooAw=";
  };

  ouch_plug = pkgs.fetchFromGitHub {
    owner = "ndtoan96";
    repo = "ouch.yazi";
    rev = "1ee69a56da3c4b90ec8716dd9dd6b82e7a944614";
    hash = "sha256-4KZeDkMXlhUV0Zh+VGBtz9kFPGOWCexYVuKUSCN463o=";
  };

  torrent-preview_plug = pkgs.fetchFromGitHub {
    owner = "kirasok";
    repo = "torrent-preview.yazi";
    rev = "4ca5996a8264457cbefff8e430acfca4900a0453";
    hash = "sha256-vaeOdNa56wwzBV6DgJjprRlrAcz2yGUYsOveTJKFv6M=";
  };

  mediainfo_plug = pkgs.fetchFromGitHub {
    owner = "boydaihungst";
    repo = "mediainfo.yazi";
    rev = "a7d1aa69a1a107e64540c17f19ac94be1366769f";
    hash = "sha256-HUD8Sv1C4gzZRvSEIYqcmm+A0mBYDuwZHCNH26kipS0=";
  };
in {
  home.packages = with pkgs; [
    file
    ffmpegthumbnailer
    unar
    jq
    poppler
    fzf

    glow
    hexyl
    miller
    exiftool
    ouch
    transmission_4
    mediainfo
    ffmpeg
  ];
  programs.yazi = {
    enable = true;
    initLua = ./init.lua;
    package = inputs.yazi.packages.${pkgs.system}.default;
    enableFishIntegration = true;
    plugins = {
      full-border = "${plugs}/full-border.yazi";
      chmod = "${plugs}/chmod.yazi";
      max-preview = "${plugs}/max-preview.yazi";
      hide-preview = "${plugs}/hide-preview.yazi";
      smart-filter = "${plugs}/smart-filter.yazi";
      jump-to-char = "${plugs}/jump-to-char.yazi";
      diff = "${plugs}/diff.yazi";
      git = "${plugs}/git.yazi";
      piper = "${plugs}/piper.yazi";

      exifaudio = exifaudio;
      ouch = ouch_plug;
      torrent-preview = torrent-preview_plug;
      mediainfo = mediainfo_plug;
    };
    keymap = {
      mgr.prepend_keymap = [
        {
          on = ["<C-s>"];
          run = ''shell "$SHELL" --block --confirm'';
          desc = "Open shell here";
        }

        {
          on = ["y"];
          run = [''shell 'for path in "$@"; do echo "file://$path"; done | wl-copy -t text/uri-list' --confirm'' "yank"];
        }

        {
          on = ["<C-e>"];
          run = "seek 5";
          desc = "glow.yazi scroll up";
        }
        {
          on = ["<C-y>"];
          run = "seek -5";
          desc = "glow.yazi scroll down";
        }

        # Plugins
        {
          on = ["c" "m"];
          run = "plugin chmod";
          desc = "Chmod on selected files";
        }

        {
          on = "T";
          run = "plugin --sync max-preview";
          desc = "Maximize or restore preview";
        }

        {
          on = "Y";
          run = "plugin --sync hide-preview";
          desc = "Hide or show preview";
        }

        {
          on = "F";
          run = "plugin smart-filter";
          desc = "Smart filter";
        }

        {
          on = "f";
          run = "plugin jump-to-char";
          desc = "Jump to char";
        }

        {
          on = "<C-d>";
          run = "plugin diff";
          desc = "Diff the selected with the hovered file";
        }
      ];
    };
    settings = {
      mgr = {
        show_symlink = false;
        show_hidden = true;
      };
      plugin = {
        prepend_previewers = [
          {
            name = "*.md";
            run = "piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dark \"$1\"";
          }
          {
            mime = "text/csv";
            run = "piper -- mlr --icsv --opprint -C --key-color darkcyan --value-color grey70 cat \"$1\"";
          }
          {
            mime = "audio/*";
            run = "exifaudio";
          }

          # Archive previewer
          {
            mime = "application/*zip";
            run = "ouch";
          }
          {
            mime = "application/x-tar";
            run = "ouch";
          }
          {
            mime = "application/x-bzip2";
            run = "ouch";
          }
          {
            mime = "application/x-7z-compressed";
            run = "ouch";
          }
          {
            mime = "application/x-rar";
            run = "ouch";
          }
          {
            mime = "application/x-xz";
            run = "ouch";
          }

          {
            mime = "application/bittorrent";
            run = "torrent-preview";
          }

          {
            mime = "{image,audio,video}/*";
            run = "mediainfo";
          }
          {
            mime = "application/subrip";
            run = "mediainfo";
          }
        ];
        append_previewers = [
          {
            name = "*";
            run = "piper -- hexyl --border=none --terminal-width=$w \"$1\"";
          }
        ];

        prepend_fetchers = [
          {
            id = "git";
            name = "*";
            run = "git";
          }

          {
            id = "git";
            name = "*/";
            run = "git";
          }
        ];
      };
      tasks = {
        image_bound = [0 0];
      };
    };
    theme = fromTOML (builtins.readFile ./theme.toml);
  };
  catppuccin.glamour.enable = true;
  catppuccin.fzf.enable = true;
}
