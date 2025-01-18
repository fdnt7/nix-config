{pkgs, ...}: {
  home.packages = with pkgs; [
    chafa
    libsixel
    poppler_utils
    atool
    ffmpeg
    colordiff
    fontforge
    elinks
    libreoffice
    imagemagick
    ffmpegthumbnailer
    mdcat
    ctpv
  ];

  xdg = {
    configFile = {
      "lf/icons".source = ./icons;
      "lf/colors".source = ./colours;
      "ctpv/config".text = ''
        	set chafasixel
        	preview image image/* {{
        	chafa -s "''${w}x''${h}" -f sixels --polite on "$f"
        }}
      '';
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
