{
  inputs,
  pkgs,
  ...
}: let
  plugs = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "b8860253fc44e500edeb7a09db648a829084facd";
    hash = "sha256-29K8PmBoqAMcQhDIfOVnbJt2FU4BR6k23Es9CqyEloo=";
  };

  exifaudio = pkgs.fetchFromGitHub {
    owner = "Sonico98";
    repo = "exifaudio.yazi";
    rev = "4506f9d5032e714c0689be09d566dd877b9d464e";
    hash = "sha256-RWCqWBpbmU3sh/A+LBJPXL/AY292blKb/zZXGvIA5/o=";
  };

  ouch_plug = pkgs.fetchFromGitHub {
    owner = "ndtoan96";
    repo = "ouch.yazi";
    rev = "bb941c4891b21762f98318a6ad484827726019e6";
    hash = "sha256-g/ZHArXksRo49k9UBHap0CXzIdycQigjbdCzDK1VaLY=";
  };

  torrent-preview_plug = pkgs.fetchFromGitHub {
    owner = "kirasok";
    repo = "torrent-preview.yazi";
    rev = "f46528243c458de3ffce38c44607d5a0cde67559";
    hash = "sha256-VhJvNRKHxVla4v2JJeSnP0MOMBFSm4k7gfqjrHOMVlo=";
  };

  mediainfo_plug = pkgs.fetchFromGitHub {
    owner = "boydaihungst";
    repo = "mediainfo.yazi";
    rev = "cc12f3f097cc57e41186697bd45d0e1598dc81ae";
    hash = "sha256-CTynpmB101ylCiHKbwX5nVrt5OMhgAu48GVxXsNqd9s=";
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
