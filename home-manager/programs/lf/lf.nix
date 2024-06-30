{pkgs, ...}: {
  home.packages = [
    pkgs.chafa
    pkgs.libsixel
    pkgs.poppler_utils
    pkgs.atool
    pkgs.ffmpeg
    pkgs.colordiff
    pkgs.fontforge
    pkgs.elinks
    pkgs.libreoffice
    pkgs.imagemagick
    pkgs.ffmpegthumbnailer
    pkgs.mdcat
  ];

  xdg = {
    configFile = {
      "lf/icons".source = ./icons;
      "lf/colors".source = ./colours;
      #"ctpv/config".text = "set chafasixel";
    };
  };

  programs.lf = {
    enable = true;
    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
      cursorpreviewfmt = "\\033[7m";
      cursoractivefmt = "\\033[7m";
      cursorparentfmt = "\\033[7m";
      sixel = true;
    };
    keybindings = {
      "." = "set hidden!";
    };
    previewer = {
      keybinding = "i";
      source = "${pkgs.ctpv}/bin/ctpv";
    };
    extraConfig = ''
      &${pkgs.ctpv}/bin/ctpv -s $id
      cmd on-quit %${pkgs.ctpv}/bin/ctpv -e $id
      set cleaner ${pkgs.ctpv}/bin/ctpvclear
    '';
  };
}
