{pkgs, ...}: let
in {
  home.packages = [
    (import scripts/exec-once.nix {inherit pkgs;})
    (import scripts/toggle-touchpad.nix {inherit pkgs;})
  ];
  xdg.configFile = {
    #"hypr/hyprland/icons".source = ./icons;
  };
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
    settings = {
      monitor = ",preferred,auto,1";
      exec-once = "exec-once";

      input = {
        kb_layout = "us,th";
        kb_options = "caps:escape_shifted_capslock,grp:win_escape_toggle";
        #kb_options = "caps:swapescape,grp:win_escape_toggle";
        numlock_by_default = true;
        repeat_rate = 40;
        repeat_delay = 200;
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
        };
        sensitivity = 0;
        accel_profile = "flat";
      };

      general = {
        gaps_in = 3;
        gaps_out = 5;
        border_size = 1;
        "col.active_border" = "rgb(AEFFFC) rgb(C4A3EF) rgb(F1C3ED) 30deg";
        layout = "dwindle";
        allow_tearing = true;
      };

      decoration = {
        rounding = 0;
        blur = {
          enabled = true;
          size = 8;
          passes = 1;
          special = false;
        };

        drop_shadow = false;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
        dim_special = 0.5;
        #inactive_opacity = 0.8;
      };

      group = {
        "col.border_active" = "rgb(FAF1EB) rgb(F7DDB9) 30deg";
        "col.border_inactive" = "rgb(3d2d17)";
        "col.border_locked_active" = "rgb(ffa8ba) rgb(f57d95) 30deg";
        "col.border_locked_inactive" = "rgb(401622)";
        groupbar = {
          enabled = true;
          font_family = "JetBrainsMono Nerd Font";
          font_size = 9;
          height = 12;
          "col.active" = "rgba(855b4088)";
          "col.inactive" = "rgba(3d2d1744)";
          "col.locked_active" = "rgba(f57d9588)";
          "col.locked_inactive" = "rgba(40162244)";
        };
      };

      animations = {
        enabled = true;
        animation = [
          "windowsIn, 1, 3, default, popin 50%"
          "windowsOut, 1, 4, default, popin 75%"
          "windowsMove, 1, 3, default"
          "border, 1, 10, default"
          "borderangle, 1, 7.5, default"
          "fade, 1, 7, default"
          "workspaces, 1, 3, default, slidefade 10%"
          "specialWorkspace, 1, 4, default, slidefadevert 5%"
          "layers, 1, 2.5, default, fade"
          "fadeLayers, 1, 2.5, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        no_gaps_when_only = true;
        #special_scale_factor = 0.95;
      };

      gestures = {
        workspace_swipe = true;
      };

      misc = {
        disable_hyprland_logo = true;
      };

      "$LAPTOP_TOUCHPAD_ENABLED" = false;
      device = {
        name = "asuf1204:00-2808:0202-touchpad";
        enabled = "$LAPTOP_TOUCHPAD_ENABLED";
      };

      windowrulev2 = [
        "suppressevent maximize, class:.*"

        "workspace 1, class:^(brave-browser(-nightly)?)$"
        "workspace 1, class:^(firefox)$"
        "workspace 3, class:^(Code)$"
        "workspace 5, class:^(Gimp)$"
        "workspace 5, class:^(krita)$"
        "workspace 6, class:^(MuseScore4)$"
        "workspace 6, class:^(Muse Sounds Manager)$"
        "workspace 8, class:^(steam_app_)(\\d+)$"

        "float, class:^(oculante)$"
        "float, class:^(pix)$"
        "float, class:^(swayimg_.*)$"

        "noblur, class:^(Xdg-desktop-portal-gtk)$"

        "noborder, class:^(Xdg-desktop-portal-gtk)$"

        "workspace special:minimised, class:^(steam)$"

        "workspace special:chat, class:^(vesktop)$"
        "workspace special:chat, class:^(discord)$"

        "workspace special:music, class:^(Spotify)$"
        "workspace special:music, class:^(jamesdsp)$"

        "workspace special:scratch, class:^(Alacritty)$"
        "workspace special:scratch, class:^(kitty)$"
      ];

      layerrule = [
        "blur, swaync-control-center"
        "blur, swaync-notification-window"

        "ignorezero, swaync-control-center"
        "ignorezero, swaync-notification-window"

        "ignorealpha 0.5, swaync-control-center"
        "ignorealpha 0.5, swaync-notification-window"
      ];

      "$mod" = "SUPER";
      "$sws_1" = "grave";
      "$sws_2" = "minus";
      "$sws_3" = "equal";
      "$sws_4" = "BackSpace";

      "$term" = "alacritty";
      "$term_alt" = "kitty";

      bindr = [
        "MOD2, Num_Lock , exec, swayosd-client --num-lock"
        "CAPS, Caps_Lock, exec, swayosd-client --caps-lock"
      ];

      binde = [
        "$mod CTRL, l,resizeactive,10 0"
        "$mod CTRL, h,resizeactive,-10 0"
        "$mod CTRL, k,resizeactive,0 -10"
        "$mod CTRL, j,resizeactive,0 10"

        "$mod, Tab, changegroupactive, f"
        "$mod SHIFT, Tab, changegroupactive, b"
      ];

      bind =
        [
          "            , XF86AudioLowerVolume , exec, swayosd-client --output-volume lower"
          "            , XF86AudioRaiseVolume , exec, swayosd-client --output-volume raise"
          "            , XF86AudioMicMute     , exec, swayosd-client --input-volume mute-toggle"
          "            , XF86Launch3          , exec,"

          "            , XF86AudioMute        , exec, swayosd-client --output-volume mute-toggle" #fn+f1
          #fn+f2 o
          #fn+f3 o
          "            , XF86Launch4, exec," #fn+f4
          #fn+f5 -
          "$mod Shift_L, s                    , exec, grimblast --notify copysave area" #fn+f6
          "            , xf86monbrightnessup  , exec, swayosd-client --brightness raise" #fn+f7
          "            , xf86monbrightnessdown, exec, swayosd-client --brightness lower" #fn+f8
          "$mod        , p                    , exec," #fn+f9
          "            , XF86TouchPadToggle   , exec, toggle-touchpad" #fn+f10
          #fn+f11 o
          #fn+f12 -

          "    , Print, exec, grimblast --notify copysave screen"
          "$mod, Print, exec, grimblast --notify copysave active"

          "$mod, q, exec,"
          "$mod SHIFT, q, exit"
          "$mod, w, killactive"
          "$mod, r, exec, rofi -show run -show-icons"
          "$mod, t, pseudo"
          "$mod, i, pin"
          "$mod, o, toggleopaque"
          "$mod, bracketleft , alterzorder, bottom"
          "$mod, bracketright, alterzorder, top"
          "$mod, a, exec, rofi -show drun -show-icons"
          "$mod, s, togglesplit"
          "$mod, f, togglefloating"
          "$mod SHIFT, f, fullscreen"
          "$mod, g, togglegroup"
          "$mod SHIFT, g, lockactivegroup, toggle"
          "$mod, h, movefocus, l"
          "$mod, j, movefocus, d"
          "$mod, k, movefocus, u"
          "$mod, l, movefocus, r"
          "$mod SHIFT, l, exec, hyprlock"

          "$mod ALT, s, exec, spotify"
          "$mod ALT, f, exec, dolphin"
          "$mod ALT, m, exec, mscore"
          "$mod ALT, z, exec, zed"
          "$mod ALT, c, exec, code"

          "$mod, Return, exec, $term"
          "$mod, Shift_R, exec, $term_alt"

          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

          "$mod, $sws_1, togglespecialworkspace, scratch"
          "$mod SHIFT, $sws_1, movetoworkspace, special:scratch"
          "$mod, $sws_2, togglespecialworkspace, minimised"
          "$mod SHIFT, $sws_2, movetoworkspace, special:minimised"
          "$mod, $sws_3, togglespecialworkspace, music"
          "$mod SHIFT, $sws_3, movetoworkspace, special:music"
          "$mod, $sws_4, togglespecialworkspace, chat"
          "$mod SHIFT, $sws_4, movetoworkspace, special:chat"
        ]
        ++ (
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
    extraConfig = ''
      bind=$mod, n, exec, swaync-client -op -sw
      bind=$mod, n, submap, notify
      submap=notify
        bind=    , c     , exec  , swaync-client -C -sw
        bind=    , c     , exec  , swaync-client -cp -sw
        bind=    , c     , submap, reset
        bind=    , d     , exec  , swaync-client -d -sw
        bind=    , d     , exec  , swaync-client -cp -sw
        bind=    , d     , submap, reset
        bind=$mod, n     , exec  , swaync-client -cp -sw
        bind=$mod, n     , submap, reset
        bind=    , escape, exec  , swaync-client -cp -sw
        bind=    , escape, submap, reset
      submap=reset

      bind=$mod ALT, d, submap, discord
      submap=discord
        bind=, v     , exec  , vesktop
        bind=, v     , submap, reset
        bind=, d     , exec  , discord
        bind=, d     , submap, reset
        bind=, escape, submap, reset
      submap=reset

      bind=$mod ALT, b, submap, browser
      submap=browser
        bind=, b     , exec  , brave
        bind=, b     , submap, reset
        bind=, f     , exec  , firefox
        bind=, f     , submap, reset
        bind=, escape, submap, reset
      submap=reset
    '';
  };
}