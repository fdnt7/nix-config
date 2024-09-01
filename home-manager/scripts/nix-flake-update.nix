{
  pkgs,
  config,
}: let
  FLAKE_DIR = "${config.home.sessionVariables.FLAKE}";
  GIT = "${pkgs.git}/bin/git";
in
  pkgs.writeShellScriptBin "nix-flake-update" ''
    (cd ${FLAKE_DIR} &&
    nix flake update &&
    ${GIT} diff --minimal &&
    ${GIT} add flake.lock &&
    ${GIT} commit -m update)
  ''
