{...}: {
  services.swaync = {
    enable = true;
    settings = {
      "$schema" = "/run/current-system/sw/etc/xdg/swaync/configSchema.json";
      "positionX" = "right";
      "positionY" = "bottom";
      "control-center-margin-top" = 5;
      "control-center-margin-bottom" = 5;
      "control-center-margin-right" = 5;
      "control-center-margin-left" = 5;
      "notification-icon-size" = 48;
      "notification-body-image-height" = 160;
      "notification-body-image-width" = 90;
      "timeout" = 5;
      "timeout-low" = 3;
      "timeout-critical" = 0;
      "fit-to-screen" = true;
      "control-center-width" = 380;
      "notification-window-width" = 366;
      "keyboard-shortcuts" = true;
      "image-visibility" = "when-available";
      "transition-time" = 100;
      "hide-on-clear" = false;
      "hide-on-action" = true;
      "script-fail-notify" = true;
      "scripts" = {
        "example-script" = {
          "exec" = "echo 'Do something...'";
          "urgency" = "Normal";
        };
      };
      "notification-visibility" = {
        "example-name" = {
          "state" = "muted";
          "urgency" = "Low";
          "app-name" = "Spotify";
        };
      };
      "widgets" = [
        "notifications"
        "dnd"
        "title"
        "mpris"
      ];
      "widget-config" = {
        "title" = {
          "text" = "Notifications";
          "clear-all-button" = true;
          "button-text" = "Clear All";
        };
        "dnd" = {
          "text" = "Do Not Disturb";
        };
        "mpris" = {
          "image-size" = 48;
          "image-radius" = 0;
        };
      };
    };

    style = ./style.css;
  };
}
