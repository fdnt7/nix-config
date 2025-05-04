{
  pkgs,
  inputs,
  ...
}: let
in {
  home.packages = [
    (import ./scripts/exec-once.nix {inherit pkgs;})
    (import ./scripts/toggle-touchpad.nix {inherit pkgs;})
    (import ./scripts/swww-next.nix {inherit pkgs;})
    (import ./scripts/lock.nix {inherit inputs pkgs;})
    pkgs.hyprpolkitagent
  ];
  xdg.configFile = {
    #"hypr/hyprland/icons".source = ./icons;
  };
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd = {
      #enable = true;
      #variables = ["--all"];
      enable = false;
    };
    settings = {
      monitor = [
        "eDP-2,preferred,auto,1"
        ",preferred,auto,1,mirror,eDP-2"
      ];
      exec-once = "exec-once";

      input = {
        kb_layout = "us,th";
        kb_options = "caps:escape_shifted_capslock,grp:win_space_toggle";
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
        #allow_tearing = true;
      };

      decoration = {
        rounding = 0;
        blur = {
          enabled = true;
          size = 8;
          passes = 1;
          special = false;
        };

        shadow = {
          enabled = false;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

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
          font_size = 10;
          height = 12;
          gaps_in = 0;
          gaps_out = 0;
          gradients = true;
          "col.active" = "rgba(3d372efe)";
          "col.inactive" = "rgba(000000fe)";
          "col.locked_active" = "rgba(401622fe)";
          "col.locked_inactive" = "rgba(000000fe)";
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
        #special_scale_factor = 0.95;
      };

      gestures = {
        workspace_swipe = true;
      };

      misc = {
        disable_hyprland_logo = true;
      };

      "$LAPTOP_TOUCHPAD_ENABLED" = true;
      device = {
        name = "asuf1204:00-2808:0202-touchpad";
        enabled = "$LAPTOP_TOUCHPAD_ENABLED";
      };

      workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"

        "pin, class:^(pinentry-qt)$"

        "workspace 1, class:^(brave-browser(-nightly)?)$"
        "workspace 1, class:^(firefox)$"
        "workspace 1, class:^(Vivaldi-stable)$"
        "workspace 3, class:^(Code)$"
        "workspace 3, class:^(dev.zed.Zed)$"
        "workspace 5, class:^(Gimp)$"
        "workspace 5, class:^(krita)$"
        "workspace 6, class:^(MuseScore4)$"
        "workspace 6, class:^(Muse Sounds Manager)$"
        "workspace 8, class:^(steam_app_)(\\d+)$"
        "workspace 8, class:^(osu!)$"

        "float, class:^(oculante)$"
        "float, class:^(pix)$"
        "float, class:^(swayimg_.*)$"
        "float, class:^(mscore4portable)$"
        "float, class:^(Muse Sounds Manager)$"
        "float, class:^(jamesdsp)$"
        "float, class:^(pavucontrol)$"
        "float, class:^(mpv)$"
        "float, class:^(nm-connection-editor)$"

        "noblur, class:^(Xdg-desktop-portal-gtk)$"
        "noblur, class:^(MuseScore4)$"
        "noblur, class:^()$, title:^()$"

        "noborder, class:^(Xdg-desktop-portal-gtk)$"

        "workspace special:minimised, class:^(steam)$"

        "workspace special:chat, class:^(vesktop)$"
        "workspace special:chat, class:^(discord)$"
        "workspace special:chat, class:^(de.shorsh.discord-screenaudio)$"

        "workspace special:music, class:^(Spotify)$"
        "workspace special:music, class:^(jamesdsp)$"
        "workspace special:music, class:^(pavucontrol)$"

        "workspace special:scratch, class:^(Alacritty)$"
        "workspace special:scratch, class:^(org.wezfurlong.wezterm)$"
        "workspace special:scratch, class:^(foot)$"
        "workspace special:scratch, class:^(kitty)$"

        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
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
      "$term_alt" = "foot";

      bindr = [
        "MOD2, Num_Lock , exec, uwsm app -- swayosd-client --num-lock"
        "CAPS, Caps_Lock, exec, uwsm app -- swayosd-client --caps-lock"
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
          "            , XF86AudioLowerVolume , exec, uwsm app -- swayosd-client --output-volume lower"
          "            , XF86AudioRaiseVolume , exec, uwsm app -- swayosd-client --output-volume raise"
          "            , XF86AudioMicMute     , exec, uwsm app -- swayosd-client --input-volume mute-toggle"
          "            , XF86Launch3          , exec, uwsm app --"

          "            , XF86AudioMute        , exec, uwsm app -- swayosd-client --output-volume mute-toggle" #fn+f1
          #fn+f2 o
          #fn+f3 o
          "            , XF86Launch4, exec    , exec, uwsm app --" #fn+f4
          #fn+f5 -
          "$mod Shift_L, s                    , exec, uwsm app -- grimblast --notify copysave area" #fn+f6
          "            , xf86monbrightnessup  , exec, uwsm app -- swayosd-client --brightness raise" #fn+f7
          "            , xf86monbrightnessdown, exec, uwsm app -- swayosd-client --brightness lower" #fn+f8
          "$mod        , p                    , exec, uwsm app --" #fn+f9
          "            , XF86TouchPadToggle   , exec, uwsm app -- toggle-touchpad" #fn+f10
          #fn+f11 o
          #fn+f12 -

          "    , Print, exec, uwsm app -- grimblast --notify copysave screen"
          "$mod, Print, exec, uwsm app -- grimblast --notify copysave active"

          "$mod SHIFT, q, exit"
          "$mod, w, killactive"
          "$mod, e, swapnext"
          "$mod SHIFT, e, swapnext, prev"
          "$mod, r, exec, uwsm app -- rofi -show run -show-icons"
          "$mod, t, pseudo"
          "$mod           , y, cyclenext, tiled"
          "$mod SHIFT     , y, cyclenext, prev tiled"
          "$mod CTRL      , y, cyclenext, floating"
          "$mod CTRL SHIFT, y, cyclenext, floating"
          "$mod, u, moveoutofgroup"
          "$mod, i, pin"
          "$mod, bracketleft , alterzorder, bottom"
          "$mod, bracketright, alterzorder, top"

          "$mod, a, exec, uwsm app -- rofi -show drun -show-icons"
          "$mod, s, togglesplit"
          "$mod, f, togglefloating"
          "$mod SHIFT, f, fullscreen"
          "$mod, g, togglegroup"
          "$mod SHIFT, g, lockactivegroup, toggle"
          "$mod, h, movefocus, l"
          "$mod, j, movefocus, d"
          "$mod, k, movefocus, u"
          "$mod, l, movefocus, r"
          "$mod SHIFT, h, swapwindow, l"
          "$mod SHIFT, j, swapwindow, d"
          "$mod SHIFT, k, swapwindow, u"
          "$mod SHIFT, l, swapwindow, r"
          "$mod CTRL SHIFT, h, moveintogroup, l"
          "$mod CTRL SHIFT, j, moveintogroup, d"
          "$mod CTRL SHIFT, k, moveintogroup, u"
          "$mod CTRL SHIFT, l, moveintogroup, r"
          "$mod, semicolon, exec, uwsm app -- lock"
          "$mod CTRL, s, exec, uwsm app -- swww-next"

          "$mod, c, centerwindow"

          "$mod ALT, s, exec, uwsm app -- spotify"
          "$mod ALT, f, exec, uwsm app -- dolphin"
          "$mod ALT, m, exec, uwsm app -- mscore"
          "$mod ALT, z, exec, uwsm app -- zed"
          "$mod ALT, c, exec, uwsm app -- code"
          "$mod ALT, v, exec, uwsm app -- pavucontrol"
          "$mod ALT, j, exec, uwsm app -- jamesdsp"
          "$mod ALT, x, exec, uwsm app -- xournalpp"

          "$mod, Return , exec, $term"
          "$mod, Shift_R, exec, $term_alt"

          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

          "$mod      , $sws_1, togglespecialworkspace, scratch"
          "$mod CTRL , $sws_1, movetoworkspace       , special:scratch"
          "$mod SHIFT, $sws_1, movetoworkspacesilent, special:scratch"
          "$mod      , $sws_2, togglespecialworkspace, minimised"
          "$mod CTRL , $sws_2, movetoworkspace       , special:minimised"
          "$mod SHIFT, $sws_2, movetoworkspacesilent, special:minimised"
          "$mod      , $sws_3, togglespecialworkspace, music"
          "$mod CTRL , $sws_3, movetoworkspace       , special:music"
          "$mod SHIFT, $sws_3, movetoworkspacesilent, special:music"
          "$mod      , $sws_4, togglespecialworkspace, chat"
          "$mod CTRL , $sws_4, movetoworkspace       , special:chat"
          "$mod SHIFT, $sws_4, movetoworkspacesilent, special:chat"
        ]
        ++ (
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod      , ${ws}, workspace            , ${toString (x + 1)}"
                "$mod CTRL , ${ws}, movetoworkspace      , ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
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
      bind=$mod, n, exec, uwsm app -- swaync-client -op -sw
      bind=$mod, n, submap, notify
      submap=notify
        bind=    , c     , exec  , uwsm app -- swaync-client -C -sw
        bind=    , c     , exec  , uwsm app -- swaync-client -cp -sw
        bind=    , c     , submap, reset
        bind=    , d     , exec  , uwsm app -- swaync-client -d -sw
        bind=    , d     , exec  , uwsm app -- swaync-client -cp -sw
        bind=    , d     , submap, reset
        bind=$mod, n     , exec  , uwsm app -- swaync-client -cp -sw
        bind=$mod, n     , submap, reset
        bind=    , escape, exec  , uwsm app -- swaync-client -cp -sw
        bind=    , escape, submap, reset
      submap=reset

      bind=$mod ALT, d, submap, discord
      submap=discord
        bind=, v     , exec  , uwsm app -- vesktop
        bind=, v     , submap, reset
        bind=, d     , exec  , uwsm app -- discord
        bind=, d     , submap, reset
        bind=, s     , exec  , uwsm app -- discord-screenaudio
        bind=, s     , submap, reset
        bind=, c     , exec  , uwsm app -- discordcanary
        bind=, c     , submap, reset
        bind=, escape, submap, reset
      submap=reset

      bind=$mod ALT, b, submap, browser
      submap=browser
        bind=, b     , exec  , uwsm app -- brave
        bind=, b     , submap, reset
        bind=, f     , exec  , uwsm app -- firefox
        bind=, f     , submap, reset
        bind=, v     , exec  , uwsm app -- vivaldi
        bind=, v     , submap, reset
        bind=, escape, submap, reset
      submap=reset

      bind=$mod, q, submap, power
      submap=power
        bind=, s     , exec  , poweroff
        bind=, s     , submap, reset
        bind=, r     , exec  , reboot
        bind=, r     , submap, reset
        bind=, escape, submap, reset
      submap=reset

      bind=$mod, d, submap, develop
      submap=develop
        bind=, l     , exec  , uwsm app -- nix-develop-lyra
        bind=, l     , submap, reset
        bind=, escape, submap, reset
      submap=reset
    '';
  };
}
