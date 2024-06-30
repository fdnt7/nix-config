{
  pkgs,
  inputs,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${pkgs.system}.default;
    settings = {
      background = [
        {
          monitor = "";
          path = "$XDG_STATE_HOME/hyprlock-background";
          blur_passes = 1;
          blur_size = 8;
          brightness = 0.5;
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          text_align = "right";
          color = "rgba(255, 255, 255, 1.0)";
          font_size = 64;
          font_family = "JetBrainsMono Nerd Font";

          position = "-32, 128";
          halign = "right";
          valign = "bottom";
        }
        {
          monitor = "";
          text = "cmd[update:43200000] echo \"$(LC_ALL=en_US.utf8 date +\"%A, %B %-d\")\"";
          text_align = "right";
          color = "rgba(255, 255, 255, 1.0)";
          font_size = 32;
          font_family = "JetBrainsMono Nerd Font";

          position = "-32, 72";
          halign = "right";
          valign = "bottom";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "32, 32";
          outline_thickness = 1;
          dots_size = 0.5; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.15; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = false;
          dots_rounding = -1; # -1 default circle, -2 follow input-field rounding
          outer_color = "rgb(151515)";
          inner_color = 0;
          font_color = "rgb(255, 255, 255)";
          fade_on_empty = true;
          fade_timeout = 1000; # Milliseconds before fade_on_empty is triggered.
          placeholder_text = ""; # Text rendered in the input box when it's empty.
          hide_input = true;
          rounding = 0; # -1 means complete rounding (circle/oval)
          check_color = "rgb(243, 161, 255)";
          fail_color = "rgb(255, 87, 137)"; # if authentication failed, changes outer_color and fail message color
          fail_text = ""; # <span foreground="white"><b>$ATTEMPTS</b></span>
          fail_transition = 300; # transition time in ms between normal outer_color and fail_color
          capslock_color = "rgb(61, 53, 33)";
          numlock_color = "rgb(44, 36, 61)";
          bothlock_color = "rgb(59, 107, 58)"; # when both locks are active. -1 means don't change outer color (same for above)
          invert_numlock = false; # change color if numlock is off
          swap_font_color = false; # see below

          position = "-32, 24";
          halign = "right";
          valign = "bottom";
        }
      ];
    };
  };
}
