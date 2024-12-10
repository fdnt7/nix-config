{
  inputs,
  pkgs,
  ...
}: let
  plugs = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "776b160c3fa5419265342b0e0c2ec63bb8311679";
    hash = "sha256-THgGAsJr0ptZ3hu29u53X1tjSxFLe5woKYdIwewZzp8=";
  };

  glow_plug = pkgs.fetchFromGitHub {
    owner = "Reledia";
    repo = "glow.yazi";
    rev = "c2ed51ed8c4ba965b793adab5868a307ab375c8a";
    hash = "sha256-hY390F6/bkQ6qN2FZEn0k+j+XfaERJiAo/E3xXYRB70=";
  };

  miller_plug = pkgs.fetchFromGitHub {
    owner = "Reledia";
    repo = "miller.yazi";
    rev = "40e02654725a9902b689114537626207cbf23436";
    hash = "sha256-GXZZ/vI52rSw573hoMmspnuzFoBXDLcA0fqjF76CdnY=";
  };

  hexyl_plug = pkgs.fetchFromGitHub {
    # owner = "Reledia";
    owner = "fdnt7";
    repo = "hexyl.yazi";
    rev = "39d3d4e23ad7cec8888f648ddf55af4386950ce7";
    hash = "sha256-nsnnL3GluKk/p1dQZTZ/RwQPlAmTBu9mQzHz1g7K0Ww=";
  };

  exifaudio = pkgs.fetchFromGitHub {
    owner = "Sonico98";
    repo = "exifaudio.yazi";
    rev = "855ff055c11fb8f268b4c006a8bd59dd9bcf17a7";
    hash = "sha256-8f1iG9RTLrso4S9mHYcm3dLKWXd/WyRzZn6KNckmiCc=";
  };

  ouch_plug = pkgs.fetchFromGitHub {
    owner = "ndtoan96";
    repo = "ouch.yazi";
    rev = "db1488358941a2bc9918fa91c304d6724a0bb608";
    hash = "sha256-fEfsHEddL7bg4z85UDppspVGlfUJIa7g11BwjHbufrE=";
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
