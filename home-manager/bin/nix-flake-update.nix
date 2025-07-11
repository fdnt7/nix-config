{
  pkgs,
  config,
}: let
  NH_FLAKE_DIR = "${config.home.sessionVariables.NH_FLAKE}";
  GIT = "${pkgs.git}/bin/git";
in
  pkgs.writeShellScriptBin "nix-flake-update" ''
    (cd ${NH_FLAKE_DIR} &&
    nix flake update &&
    ${GIT} diff --minimal &&
    ${GIT} add flake.lock &&
    ${GIT} commit -m update)
  ''
