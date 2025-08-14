{pkgs}: let
  SWWW-DAEMON = "${pkgs.swww}/bin/swww-daemon";
  bar = "${import ../bin/bar.nix {inherit pkgs;}}/bin/bar";
  #toggleBar = "pkill -SIGUSR1 waybar";
in
  pkgs.writeShellScriptBin "exec-once" ''
    ${SWWW-DAEMON} &
    sleep 2.5 && mullvad-vpn &

    sleep 1.5 && ${bar} 1 && sleep 10 && ${bar} 0
  ''
