{
  pkgs,
  config,
}: let
  NH_FLAKE_DIR = "${config.home.sessionVariables.NH_FLAKE}";
  GIT = "${pkgs.git}/bin/git";
  ALEJANDRA = "${pkgs.alejandra}/bin/alejandra";
  NH = "${pkgs.nh}/bin/nh";
  RG = "${pkgs.ripgrep}/bin/rg";
in
  pkgs.writeShellScriptBin "rebuild" ''
    (cd ${NH_FLAKE_DIR} &&
    ${ALEJANDRA} . &&
    ${GIT} diff --minimal &&
    ${GIT} add . &&
    ${NH} os switch --ask &&
    ${GIT} commit -m "os: $(nixos-rebuild list-generations | ${RG} current)")
  ''
