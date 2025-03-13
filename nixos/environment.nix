{pkgs, ...}: {
  environment = {
    sessionVariables = {
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_STATE_HOME = "$HOME/.local/state";
      XDG_CACHE_HOME = "$HOME/.cache";

      HISTFILE = "$XDG_STATE_HOME/bash/history";
      GNUPGHOME = "$XDG_DATA_HOME/gnupg";
      RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
      GTK2_RC_FILES = "$XDG_CONFIG_HOME/gtk-2.0/gtkrc";
      IPYTHONDIR = "$XDG_CONFIG_HOME/ipython";
      WAKATIME_HOME = "$XDG_CONFIG_HOME/wakatime";
      CARGO_HOME = "$XDG_DATA_HOME/cargo";
      ZDOTDIR = "$XDG_CONFIG_HOME/zsh";
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java";
      #NIXOS_OZONE_WL = "1";
    };
    variables = {
      EDITOR = "nvim";
    };
    systemPackages = with pkgs; [
      lxqt.lxqt-policykit
      # lf
      # ctpv
      starship
      tree
      home-manager
      #      libsForQt5.qt5.qtquickcontrols2
      #      libsForQt5.qt5.qtgraphicaleffects
      nix-diff
    ];
    pathsToLink = ["/share/zsh"];
    #enableAllTerminfo = true;
  };
}
