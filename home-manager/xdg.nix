{config, ...}: {
  xdg = {
    userDirs = {
      enable = true;
      publicShare = null;
      templates = null;
      desktop = null;
      extraConfig = {
        XDG_APPLICATIONS_DIR = "${config.home.homeDirectory}/Applications";
        XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
        XDG_WALLPAPERS_DIR = "${config.home.homeDirectory}/Pictures/Wallpapers";
      };
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "image/png" = ["oculante.desktop"];
        "image/jpeg" = ["oculante.desktop"];
        "image/gif" = ["oculante.desktop"];
        "text/plain" = ["nvim.desktop"];
      };
    };
  };
}
