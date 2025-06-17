{pkgs}: pkgs.writeShellScriptBin "toggle-waybar" "pkill -SIGUSR1 waybar"
