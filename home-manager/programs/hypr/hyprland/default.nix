{
  pkgs,
  inputs,
  ...
}: {
  imports = [(import ./bin {inherit inputs pkgs;})];
  home.packages = [
    pkgs.hyprpolkitagent
  ];
  #xdg.configFile = {
  #  "hypr/hyprland/icons".source = ./icons;
  #};
  wayland.windowManager.hyprland = let
    bar = "${import ./bin/bar.nix {inherit pkgs;}}/bin/bar";
    bar0 = "${bar} 0";
  in {
    enable = true;
    package = null;
    portalPackage = null;
    systemd = {
      #enable = true;
      #variables = ["--all"];
      enable = false;
    };
    plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
      #borders-plus-plus
      #csgo-vulkan-fix
      #hyprbars
      #hyprexpo
      #hyprfocus
      hyprscrolling
      #hyprtrails
      #hyprwinwrap
      #xtra-dispatchers
    ];
    settings = {
      monitor = [
        "eDP-2,preferred,auto,1"
        ",preferred,auto,1,mirror,eDP-2"
      ];
      exec-once = "exec-once";

      input = {
        kb_layout = "us,th";
        kb_options = "caps:escape,grp:win_space_toggle"; # allows zed's shift+end keybind
        #kb_options = "caps:swapescape,grp:win_space_toggle";
        #kb_options = "caps:escape_shifted_capslock,grp:win_space_toggle"; #
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
        #gaps_in = 3;
        #gaps_out = 5;
        gaps_in = 0;
        gaps_out = 0;
        border_size = 1;
        "col.active_border" = "rgb(AEFFFC) rgb(C4A3EF) rgb(F1C3ED) 30deg";
        layout = "scrolling";
        #layout = "dwindle";
        #allow_tearing = true;
      };

      decoration = {
        rounding = 0;
        blur = {
          enabled = true;
          size = 8;
          passes = 3;
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
          "workspaces, 1, 3, default, slidefadevert 10%"
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

      "$LAPTOP_TOUCHPAD_ENABLED" = false;
      device = {
        name = "asuf1204:00-2808:0202-touchpad";
        enabled = "$LAPTOP_TOUCHPAD_ENABLED";
      };

      workspace = [
        # `no_gaps_when_only`
        "w[t1], gapsout:0, gapsin:0"
        "w[tg1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"

        "pin, class:^(pinentry-qt)$"

        "workspace 1, class:^(brave-browser(-nightly)?)$"
        "workspace 1, class:^(firefox)$"
        "workspace 1, class:^(zen-beta)$"
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
        "float, class:^(pavucontrol)$"
        "float, class:^(mpv)$"
        "float, class:^(nm-connection-editor)$"

        "noblur, class:^(Xdg-desktop-portal-gtk)$"
        "noblur, class:^(MuseScore4)$"
        "noblur, class:^()$, title:^()$"
        "noblur, class:^(line.exe)$"

        "noshadow, class:^(line.exe)$"

        "noborder, class:^(Xdg-desktop-portal-gtk)$"

        "workspace special:minimised, class:^(steam)$"

        "workspace special:chat, class:^(vesktop)$"
        "workspace special:chat, class:^(discord)$"
        "workspace special:chat, class:^(de.shorsh.discord-screenaudio)$"

        "workspace special:music, class:^(spotify)$"
        "workspace special:music, class:^(pavucontrol)$"

        "workspace special:scratch, class:^(Alacritty)$"
        "workspace special:scratch, class:^(org.wezfurlong.wezterm)$"
        "workspace special:scratch, class:^(foot)$"
        "workspace special:scratch, class:^(kitty)$"

        # `no_gaps_when_only`
        "bordersize 0, floating:0, onworkspace:w[t1]"
        "rounding 0, floating:0, onworkspace:w[t1]"
        "bordersize 0, floating:0, onworkspace:w[tg1]"
        "rounding 0, floating:0, onworkspace:w[tg1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
      ];

      layerrule = [
        #"blur, swaync-control-center"
        #"blur, swaync-notification-window"

        "blur, notifications"

        #"ignorezero, swaync-control-center"
        #"ignorezero, swaync-notification-window"
        "ignorezero, notifications"

        #"ignorealpha 0.5, swaync-control-center"
        #"ignorealpha 0.5, swaync-notification-window"

        "noanim, wob"
      ];

      "$mod" = "SUPER";
      "$sws_1" = "grave";
      "$sws_2" = "minus";
      "$sws_3" = "equal";
      "$sws_4" = "BackSpace";

      "$term" = "foot";
      "$term_alt" = "foot";

      binde = [
        #"$mod CTRL, l,resizeactive,10 0"
        #"$mod CTRL, h,resizeactive,-10 0"
        #"$mod CTRL, k,resizeactive,0 -10"
        #"$mod CTRL, j,resizeactive,0 10"
        "$mod CTRL, h, layoutmsg, colresize -conf"
        "$mod CTRL, j, layoutmsg, colresize -0.2"
        "$mod CTRL, k, layoutmsg, colresize +0.2"
        "$mod CTRL, l, layoutmsg, colresize +conf"

        #"$mod, Tab, changegroupactive, f"
        #"$mod SHIFT, Tab, changegroupactive, b"
        "$mod, Tab, layoutmsg, move +col"
        "$mod SHIFT, Tab, layoutmsg, move -col"

        "            , XF86AudioLowerVolume , exec, set-vol sink d"
        "            , XF86AudioRaiseVolume , exec, set-vol sink u"
        "            , xf86monbrightnessdown, exec, br d" #fn+f7
        "            , xf86monbrightnessup  , exec, br u" #fn+f8
      ];

      bind =
        [
          "            , XF86AudioMicMute     , exec, uwsm-app -- toggle-mute src"
          "            , XF86Launch3          , exec, uwsm-app --"

          "            , XF86AudioMute        , exec, uwsm-app -- toggle-mute sink" #fn+f1
          #fn+f2 o
          #fn+f3 o
          "            , XF86Launch4          , exec, uwsm-app --" #fn+f4
          #fn+f5 -
          "$mod Shift_L, s                    , exec, uwsm-app -- grimblast --notify copysave area" #fn+f6
          "$mod        , p                    , exec, uwsm-app --" #fn+f9
          "            , XF86TouchPadToggle   , exec, uwsm-app -- toggle-touchpad" #fn+f10
          #fn+f11 o
          #fn+f12 -

          "    , Print, exec, uwsm-app -- grimblast --notify copysave screen"
          "$mod, Print, exec, uwsm-app -- grimblast --notify copysave active"

          "$mod SHIFT, q, exit"
          "$mod, w, killactive"
          "$mod, e, swapnext"
          "$mod SHIFT, e, swapnext, prev"
          "$mod, r, exec, uwsm-app -- rofi -show run -show-icons"
          "$mod, t, pseudo"
          "$mod           , y, cyclenext, tiled"
          "$mod SHIFT     , y, cyclenext, prev tiled"
          "$mod CTRL      , y, cyclenext, floating"
          "$mod CTRL SHIFT, y, cyclenext, floating"

          #"$mod, u, moveoutofgroup"
          "$mod, u, layoutmsg, promote"

          "$mod, i, pin"
          "$mod, bracketleft , alterzorder, bottom"
          "$mod, bracketright, alterzorder, top"

          "$mod, a, exec, uwsm-app -- rofi -show drun -show-icons"
          "$mod, s, togglesplit"
          "$mod, f, togglefloating"
          "$mod SHIFT, f, fullscreen"
          "$mod, g, togglegroup"
          "$mod SHIFT, g, lockactivegroup, toggle"

          #"$mod, h, movefocus, l"
          #"$mod, j, movefocus, d"
          #"$mod, k, movefocus, u"
          #"$mod, l, movefocus, r"
          "$mod, h, layoutmsg, focus l"
          "$mod, j, layoutmsg, focus d"
          "$mod, k, layoutmsg, focus u"
          "$mod, l, layoutmsg, focus r"

          #"$mod SHIFT, h, swapwindow, l"
          #"$mod SHIFT, j, swapwindow, d"
          #"$mod SHIFT, k, swapwindow, u"
          #"$mod SHIFT, l, swapwindow, r"
          "$mod SHIFT, h, layoutmsg, movewindowto l"
          "$mod SHIFT, j, layoutmsg, movewindowto d"
          "$mod SHIFT, k, layoutmsg, movewindowto u"
          "$mod SHIFT, l, layoutmsg, movewindowto r"

          #"$mod CTRL SHIFT, h, moveintogroup, l"
          #"$mod CTRL SHIFT, j, moveintogroup, d"
          #"$mod CTRL SHIFT, k, moveintogroup, u"
          #"$mod CTRL SHIFT, l, moveintogroup, r"
          "$mod CTRL SHIFT, h, layoutmsg, fit tobeg"
          "$mod CTRL SHIFT, l, layoutmsg, fit toend"

          "$mod, semicolon, exec, uwsm-app -- lock"
          "$mod CTRL, s, exec, uwsm-app -- swww-next"

          "$mod, c, centerwindow"

          "$mod ALT, s, exec, uwsm-app -- spotify"
          "$mod ALT, f, exec, uwsm-app -- dolphin"
          "$mod ALT, m, exec, uwsm-app -- mscore"
          "$mod ALT, z, exec, uwsm-app -- zed"
          "$mod ALT, c, exec, uwsm-app -- code"
          "$mod ALT, v, exec, uwsm-app -- pavucontrol"
          "$mod ALT, x, exec, uwsm-app -- xournalpp"

          "$mod, Return , exec, uwsm-app -- $term"
          "$mod, Shift_R, exec, uwsm-app -- $term_alt"

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

          ", SUPER_L, exec, ${bar} 1"
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
        #"$mod, mouse:272, layoutmsg, movewindowto"

        "$mod, mouse:273, resizewindow"
      ];

      bindrt = [
        "$mod, SUPER_L, exec, ${bar0}"

        "MOD2, Num_Lock , exec, uwsm-app -- showleds n"
        #"CAPS, Caps_Lock, exec, uwsm-app -- showleds c" # doesn't work due to caps:escape_shifted_capslock
        #"CAPS SHIFT, Shift_L, exec, uwsm-app -- showleds c" # only seems to work sometimes
      ];

      plugin = {
        hyprscrolling = {
          fullscreen_on_one_column = true;
          focus_fit_method = 1;
        };
      };
    };
    extraConfig = ''
      bind=$mod, n, exec, uwsm-app -- swaync-client -op -sw
      bind=$mod, n, submap, notify
      submap=notify
        bind=    , c     , exec  , ${bar0}; uwsm-app -- swaync-client -C -sw; uwsm-app -- swaync-client -cp -sw;
        bind=    , c     , submap, reset
        bind=    , d     , exec  , ${bar0}; uwsm-app -- swaync-client -d -sw; uwsm-app -- swaync-client -cp -sw;
        bind=    , d     , submap, reset
        bind=$mod, n     , exec  , ${bar0}; uwsm-app -- swaync-client -cp -sw;
        bind=$mod, n     , submap, reset
        bind=    , escape, exec  , ${bar0}; uwsm-app -- swaync-client -cp -sw;
        bind=    , escape, submap, reset
      submap=reset
      bind=$mod ALT, d, submap, discord
      submap=discord
        bind=, v     , exec  , ${bar0}; uwsm-app -- vesktop
        bind=, v     , submap, reset
        bind=, d     , exec  , ${bar0}; uwsm-app -- discord
        bind=, d     , submap, reset
        bind=, s     , exec  , ${bar0}; uwsm-app -- discord-screenaudio
        bind=, s     , submap, reset
        bind=, c     , exec  , ${bar0}; uwsm-app -- discordcanary
        bind=, c     , submap, reset
        bind=, escape, exec  , ${bar0}
        bind=, escape, submap, reset
      submap=reset
      bind=$mod ALT, b, submap, browser
      submap=browser
        bind=, b     , exec  , ${bar0}; uwsm-app -- brave;
        bind=, b     , submap, reset
        bind=, z     , exec  , ${bar0}; uwsm-app -- zen
        bind=, z     , submap, reset
        bind=, v     , exec  , ${bar0}; uwsm-app -- vivaldi
        bind=, v     , submap, reset
        bind=, escape, exec  , ${bar0}
        bind=, escape, submap, reset
      submap=reset
      bind=$mod, q, submap, power
      submap=power
        bind=, s     , exec  , poweroff
        bind=, s     , submap, reset
        bind=, r     , exec  , reboot
        bind=, r     , submap, reset
        bind=, escape, exec  , ${bar0}
        bind=, escape, submap, reset
      submap=reset
      bind=$mod, d, submap, develop
      submap=develop
        bind=, l     , exec  , ${bar0}; uwsm-app -- nix-develop-lyra
        bind=, l     , submap, reset
        bind=, escape, exec  , ${bar0}
        bind=, escape, submap, reset
      submap=reset
    '';
  };
}
