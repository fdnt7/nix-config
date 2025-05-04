{
  inputs,
  pkgs,
  ...
}: let
  plugs = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "a1738e8088366ba73b33da5f45010796fb33221e";
    hash = "sha256-eiLkIWviGzG9R0XP1Cik3Bg0s6lgk3nibN6bZvo8e9o=";
  };

  glow_plug = pkgs.fetchFromGitHub {
    owner = "Reledia";
    repo = "glow.yazi";
    rev = "2da96e3ffd9cd9d4dd53e0b2636f83ff69fe9af0";
    hash = "sha256-4krck4U/KWmnl32HWRsblYW/biuqzDPysrEn76buRck=";
  };

  miller_plug = pkgs.fetchFromGitHub {
    owner = "Reledia";
    repo = "miller.yazi";
    rev = "40e02654725a9902b689114537626207cbf23436";
    hash = "sha256-GXZZ/vI52rSw573hoMmspnuzFoBXDLcA0fqjF76CdnY=";
  };

  hexyl_plug = pkgs.fetchFromGitHub {
    owner = "Reledia";
    # owner = "fdnt7";
    repo = "hexyl.yazi";
    rev = "228a9ef2c509f43d8da1847463535adc5fd88794";
    hash = "sha256-Xv1rfrwMNNDTgAuFLzpVrxytA2yX/CCexFt5QngaYDg=";
  };

  exifaudio = pkgs.fetchFromGitHub {
    owner = "Sonico98";
    repo = "exifaudio.yazi";
    rev = "4379fcfa2dbe0b81fde2dd67b9ac2e0e48331419";
    hash = "sha256-CIimJU4KaKyaKBuiBvcRJUJqTG8pkGyytT6bPf/x8j8=";
  };

  ouch_plug = pkgs.fetchFromGitHub {
    owner = "ndtoan96";
    repo = "ouch.yazi";
    rev = "ce6fb75431b9d0d88efc6ae92e8a8ebb9bc1864a";
    hash = "sha256-oUEUGgeVbljQICB43v9DeEM3XWMAKt3Ll11IcLCS/PA=";
  };

  torrent-preview_plug = pkgs.fetchFromGitHub {
    owner = "kirasok";
    repo = "torrent-preview.yazi";
    rev = "169cafcb6f1b0aeef647c7598845e1e09651c3a8";
    hash = "sha256-taLlWoC57h8N8Yj2wD/dY+piVPgNk1F85+QIuJfQRoQ=";
  };

  mediainfo_plug = pkgs.fetchFromGitHub {
    owner = "boydaihungst";
    repo = "mediainfo.yazi";
    rev = "436cb5f04d6e5e86ddc0386527254d87b7751ec8";
    hash = "sha256-oFp8mJ62FsJX46mKQ7/o6qXPC9qx3+oSfqS0cKUZETI=";
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
    miller
    hexyl
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

      glow = glow_plug;
      miller = miller_plug;
      hexyl = hexyl_plug;
      exifaudio = exifaudio;
      ouch = ouch_plug;
      torrent-preview = torrent-preview_plug;
      mediainfo = mediainfo_plug;
    };
    keymap = {
      manager.prepend_keymap = [
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
      manager = {
        show_symlink = false;
        show_hidden = true;
      };
      plugin = {
        prepend_previewers = [
          {
            name = "*.md";
            run = "glow";
          }
          {
            mime = "text/csv";
            run = "miller";
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
            run = "hexyl";
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
    };
    theme = fromTOML (builtins.readFile ./theme.toml);
  };
  catppuccin.glamour.enable = true;
  catppuccin.fzf.enable = true;
}
