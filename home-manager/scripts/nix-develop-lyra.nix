{pkgs}: let
  LYRA_DIR = "$HOME/Code/lyra";
  CMD = "code";
in
  pkgs.writeShellScriptBin "nix-develop-lyra" ''
    (cd ${LYRA_DIR} && nix develop --impure -c ${CMD})
  ''
