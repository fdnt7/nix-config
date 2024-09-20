{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [pkgs.libappindicator pkgs.wttrbar];
  programs.waybar = {
    enable = true;
    #package = inputs.waybar.packages.${pkgs.system}.default;
    settings = {
      main = {
        layer = "top";
        position = "bottom";
        height = 26;
        spacing = 8;
        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-center = [
        ];

        modules-right = [
          "tray"
          "custom/separator"
          "custom/wttr"
          "hyprland/submap"
          "hyprland/language"
          "keyboard-state"
          "temperature"
          "cpu"
          "memory"
          "battery"
          "network"
          "privacy"
          "custom/amixer#i"
          "custom/amixer#o"
          "clock"
          "custom/swaync"
        ];

        tray = {
          spacing = 3;
        };

        "custom/amixer#o" = {
          exec = "amixer get Master | sed -nre 's/.*\\[off\\].*/  -%/p; s/.*\\[(.*%)\\].*/  \\1/p'";
          on-click = "amixer set Master toggle";
          on-scroll-up = "amixer set Master 1%+";
          on-scroll-down = "amixer set Master 1%-";
          signal = 11;
          interval = 1;
          tooltip = false;
        };

        "custom/amixer#i" = {
          exec = "amixer get Capture | sed -nre 's/.*Capture .+\\[off\\].*/  -%/p; s/.*Capture .+\\[(.*%)\\].*/ \\1/p'";
          on-click = "amixer set Capture toggle";
          on-scroll-up = "amixer set Capture 1%+";
          on-scroll-down = "amixer set Capture 1%-";
          signal = 11;
          interval = 1;
          tooltip = false;
        };

        "custom/wttr" = {
          format = "{}°";
          tooltip = true;
          interval = 3600;
          exec = "wttrbar";
          return-type = "json";
        };

        cava = {
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          bar_delimiter = 0;
          method = "pipewire";
          framerate = 24;
          bars = 4;
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "0";
          };
        };

        "hyprland/window" = {
          icon = true;
          icon-size = 18;
        };

        "hyprland/submap" = {
          format = "  {}";
        };

        "hyprland/language" = {
          format = "  {}";
          #format-en = "🇺🇸";
          format-en = "us";
          #format-th = "🇹🇭";
          format-th = "th";
        };

        temperature = {
          format = " {temperatureC}°";
        };

        network = {
          format = "{ifname}";
          #format-wifi = "{icon}  {bandwidthTotalBits:>}";
          format-wifi = "{icon}  {signalStrength:>}%";
          format-ethernet = "{icon}  {signalStrength}%";
          format-disconnected = "{icon} -";
          format-icons = {
            wifi = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
            linked = "󰄡";
            ethernet = ["󰣾" "󰣴" "󰣶" "󰣸" "󰣺"];
            disconnected = "";
          };
          tooltip-format = "{ifname} via {gwaddr}";
          tooltip-format-wifi = "{essid}  {bandwidthUpBits:>}  {bandwidthDownBits:>}";
          tooltip-format-ethernet = "{ifname}";
          tooltip-format-disconnected = "Disconnected";
          interval = 10;
          on-click = "nm-connection-editor";
        };

        battery = {
          format-discharging = "{icon} {capacity}%";
          format-charging = "{icon}󱐋 {capacity}%";
          format-full = "󱟢 100%";
          format-unknown = "󰂑 ?%";
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          states = {
            warning = 30;
            critical = 15;
          };
        };

        clock = {
          format = "󰃭 {:%Y/%m/%d 󰥔 %R}";
          format-alt = " {:%F %T}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_down";
            on-scroll-down = "shift_up";
          };
        };

        cpu = {
          format = "  {usage}%";
        };

        memory = {
          format = "  {percentage}%";
        };

        keyboard-state = {
          numlock = true;
          capslock = true;
          scrolllock = true;
          format = {
            numlock = "󰞙 {icon} ";
            capslock = "󰘲 {icon} ";
            scrolllock = "󰹹 {icon} ";
          };
          format-icons = {
            locked = "x";
            unlocked = "-";
          };
        };

        "custom/separator" = {
          tooltip = false;
          format = "󰇝";
        };

        "custom/swaync" = {
          tooltip = false;
          format = "{icon} {}";
          format-icons = {
            notification = "󰂚<span foreground='#FF77A7'><sup></sup></span>";
            none = "󰂚";
            dnd-notification = "󰂛<span foreground='#FF78A7'><sup></sup></span>";
            dnd-none = "󰂛";
            inhibited-notification = "󰂚<span foreground='#FF78A7'><sup></sup></span>";
            inhibited-none = "󰂚";
            dnd-inhibited-notification = "󰂛<span foreground='#FF78A7'><sup></sup></span>";
            dnd-inhibited-none = "󰂛";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
      };
    };

    style = ./style.css;
    systemd = {
      enable = true;
    };
  };
}
