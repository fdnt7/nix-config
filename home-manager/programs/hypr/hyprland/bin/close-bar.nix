{pkgs}: let EWW = "${pkgs.eww}/bin/eww"; in pkgs.writeShellScriptBin "close-bar" "${EWW} close bar"
