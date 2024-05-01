{
  pkgs,
  config,
}: let
  FLAKE_DIR = "${config.home.sessionVariables.FLAKE}";
  GIT = "${pkgs.git}/bin/git";
  ALEJANDRA = "${pkgs.alejandra}/bin/alejandra";
  NH = "${pkgs.nh}/bin/nh";
in
  pkgs.writeShellScriptBin "home-manager-switch-flake" ''
    (cd ${FLAKE_DIR} &&
    ${ALEJANDRA} . &> /dev/null &&
    ${GIT} --no-pager diff --minimal &&
    ${GIT} add . &&
    ${NH} home switch > /dev/null &&
    ${GIT} commit -m "home: $(readlink ${config.xdg.stateHome}/nix/profiles/home-manager | cut -d "-" -f 3)")
  ''
#${GIT} commit -m "home: $(home-manager generations | head -1 | cut -d ' ' -f 5)")

