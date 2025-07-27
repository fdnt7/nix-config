{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      mangohud
      protonup
      tetrio-desktop
      osu-lazer-bin
      #prismlauncher # broken
    ];
    sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
