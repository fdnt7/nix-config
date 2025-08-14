{...}: {
  programs.git = {
    enable = true;
    userName = "fdnt7";
    userEmail = "43757589+fdnt7@users.noreply.github.com";
    signing = {
      key = "F912A6385DDD1E38";
      signByDefault = true;
    };
    delta.enable = true;
    lfs.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  catppuccin.delta.enable = true;
}
