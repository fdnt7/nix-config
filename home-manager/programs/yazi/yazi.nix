{
  inputs,
  pkgs,
  ...
}: let
  plugs = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "4f1d0ae0862f464e08f208f1807fcafcd8778e16";
    hash = "sha256-+d7D6nq/oOzcsvvH0MHmLUDkxAtand+IXKQ730m4Ifs=";
  };

  glow_plug = pkgs.fetchFromGitHub {
    owner = "Reledia";
    repo = "glow.yazi";
    rev = "f52b3822c98dfa84998cc3140803a0704faa515d";
    hash = "sha256-bqaFqjlQ/VgMdt2VVjEI8cIkA9THjOZDgNspNicxlbc=";
  };

  miller_plug = pkgs.fetchFromGitHub {
    owner = "Reledia";
    repo = "miller.yazi";
    rev = "75f00026a0425009edb6fedcfbe893f3d2ddedf4";
    hash = "sha256-u8xadj6/s16xXUAWGezYBqnygKaFMnRUsqtjMDr6DZA=";
  };

  hexyl_plug = pkgs.fetchFromGitHub {
    # owner = "Reledia";
    owner = "fdnt7";
    repo = "hexyl.yazi";
    rev = "9bb85fe6cfe7617883d2d9921167fab323b2ea21";
    hash = "sha256-rseEV3+fyaSCz5e8msXLyyHujak3cRUUwqGuyaO8QGE=";
  };

  exifaudio = pkgs.fetchFromGitHub {
    owner = "Sonico98";
    repo = "exifaudio.yazi";
    rev = "d75db468e89ab379992c21cb745ca7920d5f409f";
    hash = "sha256-ECo0rTDF+oqRtRsqrhBuVdZtEpJShRk/XXhPwEy4cfE=";
  };

  ouch_plug = pkgs.fetchFromGitHub {
    owner = "ndtoan96";
    repo = "ouch.yazi";
    rev = "d13f7c08cdebcfaadf38c3eb9999639ddd89201c";
    hash = "sha256-Ii0gowsx6fegFNaOtThAbKaKa2WF1uavgzeONRPaQGU=";
  };

  torrent-preview_plug = pkgs.fetchFromGitHub {
    owner = "kirasok";
    repo = "torrent-preview.yazi";
    rev = "76970b6f9d6f3031e9cd57c8595a53e9f9f48c18";
    hash = "sha256-QPdtoCU7CyS7sx1aoGHNHv1NxWMA/SxSuy+2SLDdCeU=";
  };
  #mediainfo_plug = pkgs.fetchFromGitHub {
  #  owner = "Ape";
  #  repo = "mediainfo.yazi";
  #  rev = "c69314e80f5b45fe87a0e06a10d064ed54110439";
  #  hash = "sha256-8xdBPdKSiwB7iRU8DJdTHY+BjfR9D3FtyVtDL9tNiy4=";
  #};
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
    #mediainfo
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
      #mediainfo = mediainfo_plug;
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
            mime = "application/x-bittorrent";
            run = "torrent-preview";
          }

          #{
          #  mime = "{image,audio,video}/*";
          #  run = "mediainfo";
          #}
          #{
          #  mime = "application/x-subrip";
          #  run = "mediainfo";
          #}
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
}
