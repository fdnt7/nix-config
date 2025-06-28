{pkgs}: let
  SWWW-DAEMON = "${pkgs.swww}/bin/swww-daemon";
  OPEN-BAR = "${import ../scripts/open-bar.nix {inherit pkgs;}}/bin/open-bar";
  CLOSE-BAR = "${import ../scripts/close-bar.nix {inherit pkgs;}}/bin/close-bar";
  SWWW-NEXT = "${import ../scripts/swww-next.nix {inherit pkgs;}}/bin/swww-next";
in
  pkgs.writeShellScriptBin "exec-once" ''
    ${OPEN-BAR} &
    sleep 2.5 && mullvad-vpn &
    sleep 10 && ${CLOSE-BAR} &
    ${SWWW-DAEMON} &
    ${SWWW-NEXT} &
  ''
