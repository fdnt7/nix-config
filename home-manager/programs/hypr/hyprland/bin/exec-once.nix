{pkgs}: let
  SWWW-DAEMON = "${pkgs.swww}/bin/swww-daemon";
  OPEN-BAR = "${import ../bin/open-bar.nix {inherit pkgs;}}/bin/open-bar";
  CLOSE-BAR = "${import ../bin/close-bar.nix {inherit pkgs;}}/bin/close-bar";
  SWWW-NEXT = "${import ../bin/swww-next.nix {inherit pkgs;}}/bin/swww-next";
in
  pkgs.writeShellScriptBin "exec-once" ''
    ${OPEN-BAR} &
    sleep 2.5 && mullvad-vpn &
    sleep 10 && ${CLOSE-BAR} &
    ${SWWW-DAEMON} &
    ${SWWW-NEXT} &
  ''
