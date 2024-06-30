{
  inputs,
  pkgs,
  ...
}: let
  # starship = pkgs.fetchFromGitHub {
  #   owner = "Rolv-Apneseth";
  #   repo = "starship.yazi";
  #   rev = "6197e4c";
  #   hash = "sha256-oHoBq7BESjGeKsaBnDt0TXV78ggGCdYndLpcwwQ8Zts=";
  # };
  glow_plug = pkgs.fetchFromGitHub {
    owner = "Reledia";
    repo = "glow.yazi";
    rev = "536185a4e60ac0adc11d238881e78678fdf084ff";
    hash = "sha256-NcMbYjek99XgWFlebU+8jv338Vk1hm5+oW5gwH+3ZbI=";
  };

  miller_plug = pkgs.fetchFromGitHub {
    owner = "Reledia";
    repo = "miller.yazi";
    rev = "75f00026a0425009edb6fedcfbe893f3d2ddedf4";
    hash = "sha256-u8xadj6/s16xXUAWGezYBqnygKaFMnRUsqtjMDr6DZA=";
  };

  hexyl_plug = pkgs.fetchFromGitHub {
    owner = "Reledia";
    repo = "hexyl.yazi";
    rev = "64daf93a67d75eff871befe52d9013687171ffad";
    hash = "sha256-B2L3/Q1g0NOO6XEMIMGBC/wItbNgBVpbaMMhiXOYcrI=";
  };

  exifaudio = pkgs.fetchFromGitHub {
    owner = "Sonico98";
    repo = "exifaudio.yazi";
    rev = "94329ead8b3a6d3faa2d4975930a3d0378980c7a";
    hash = "sha256-jz6fVtcLHw9lsxFWECbuxE7tEBttE08Fl4oJSTifaEc=";
  };

  ouch_plug = pkgs.fetchFromGitHub {
    owner = "ndtoan96";
    repo = "ouch.yazi";
    rev = "694d149be5f96eaa0af68d677c17d11d2017c976";
    hash = "sha256-J3vR9q4xHjJt56nlfd+c8FrmMVvLO78GiwSNcLkM4OU=";
  };

  torrent-preview = pkgs.fetchFromGitHub {
    owner = "kirasok";
    repo = "torrent-preview.yazi";
    rev = "76970b6f9d6f3031e9cd57c8595a53e9f9f48c18";
    hash = "sha256-QPdtoCU7CyS7sx1aoGHNHv1NxWMA/SxSuy+2SLDdCeU=";
  };

  mime_plug = pkgs.fetchFromGitHub {
    owner = "DreamMaoMao";
    repo = "mime.yazi";
    rev = "49303d8fb60f61e91dfe355febe59332e813a6da";
    hash = "sha256-MEfD9mE3PPUmw5HsSRaCWbknc/wYGwHRyHV+0S1ux5E=";
  };
in {
  home.packages = with pkgs; [
    glow
    miller
    hexyl
    exiftool
    ouch
    transmission
  ];
  xdg.configFile = {
    "yazi/init.lua".source = ./init.lua;
    "yazi/plugins/glow.yazi".source = "${glow_plug}";
    "yazi/plugins/miller.yazi".source = "${miller_plug}";
    "yazi/plugins/hexyl.yazi".source = "${hexyl_plug}";
    "yazi/plugins/exifaudio.yazi".source = "${exifaudio}";
    "yazi/plugins/ouch.yazi".source = "${ouch_plug}";
    "yazi/plugins/torrent-preview.yazi".source = "${torrent-preview}";
    "yazi/plugins/mime.yazi".source = "${mime_plug}";
    # "yazi/plugins/starship.yazi".source = "${starship}";
  };

  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.system}.default;
    enableFishIntegration = true;
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
        ];
        append_previewers = [
          {
            name = "*";
            run = "hexyl";
          }
        ];
      };
    };
    theme = fromTOML (builtins.readFile ./theme.toml);
  };
}
