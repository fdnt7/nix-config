{pkgs}: let
  JAMESDSP = "${pkgs.jamesdsp}/bin/jamesdsp";
  SWWW-DAEMON = "${pkgs.swww}/bin/swww-daemon";
  SWWW-NEXT = "${import ../scripts/swww-next.nix {inherit pkgs;}}/bin/swww-next";
in
  pkgs.writeShellScriptBin "exec-once" ''
    ${SWWW-DAEMON} &
    ${SWWW-NEXT} &
    sleep 1 && ${JAMESDSP} -t &
  ''
