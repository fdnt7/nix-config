{pkgs}: let EWW = "${pkgs.eww}/bin/eww"; in pkgs.writeShellScriptBin "open-bar" "${EWW} open bar"
