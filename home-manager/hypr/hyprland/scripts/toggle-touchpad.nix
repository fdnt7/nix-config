{pkgs}: let
  NOTIFY-SEND = "${pkgs.libnotify}/bin/notify-send";
  HYPRCTL = "${pkgs.hyprland}/bin/hyprctl";
in
  pkgs.writeShellScriptBin "toggle-touchpad" ''
    export STATUS_FILE="$XDG_RUNTIME_DIR/touchpad.status"

    enable_touchpad() {
        printf "true" >"$STATUS_FILE"
        ${NOTIFY-SEND} -h string:x-canonical-private-synchronous:touchpad -u low -t 1000 "Enabling Touchpad"
        ${HYPRCTL} keyword '$LAPTOP_TOUCHPAD_ENABLED' "true" -r
    }

    disable_touchpad() {
        printf "false" >"$STATUS_FILE"
        ${NOTIFY-SEND} -h string:x-canonical-private-synchronous:touchpad -u low -t 1000 "Disabling Touchpad"
        ${HYPRCTL} keyword '$LAPTOP_TOUCHPAD_ENABLED' "false" -r
    }

    if ! [ -f "$STATUS_FILE" ]; then
      enable_touchpad
    else
      if [ $(cat "$STATUS_FILE") = "true" ]; then
        disable_touchpad
      elif [ $(cat "$STATUS_FILE") = "false" ]; then
        enable_touchpad
      fi
    fi
  ''
