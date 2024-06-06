{pkgs, ...}: {
  home = {
    packages = with pkgs; [mangohud protonup tetrio-desktop];
    sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
