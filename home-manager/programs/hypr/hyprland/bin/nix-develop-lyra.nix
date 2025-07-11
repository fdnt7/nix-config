{pkgs}: let
  LYRA_DIR = "$HOME/Code/lyra";
  CMD = "zeditor";
in
  pkgs.writeShellScriptBin "nix-develop-lyra" ''
    (cd ${LYRA_DIR} && nix develop --impure -c sh -c 'devenv up -D; ${CMD} .')
  ''
