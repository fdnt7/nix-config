{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    package = pkgs.callPackage ./alacritty-sixel.nix {};
    settings = {
      window = {
        opacity = 0.67;
      };
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        size = 11;
      };

      colors = {
        primary = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          dim_foreground = "#7f849c";
          bright_foreground = "#cdd6f4";
        };
        cursor = {
          text = "#1e1e2e";
          cursor = "#f5e0dc";
        };
        vi_mode_cursor = {
          text = "#1e1e2e";
          cursor = "#b4befe";
        };
        search = {
          matches = {
            foreground = "#1e1e2e";
            background = "#a6adc8";
          };
          focused_match = {
            foreground = "#1e1e2e";
            background = "#a6e3a1";
          };
        };
        footer_bar = {
          foreground = "#1e1e2e";
          background = "#a6adc8";
        };
        hints = {
          start = {
            foreground = "#1e1e2e";
            background = "#f9e2af";
          };
          end = {
            foreground = "#1e1e2e";
            background = "#a6adc8";
          };
        };
        selection = {
          text = "#1e1e2e";
          background = "#f5e0dc";
        };
        normal = {
          black = "#585b70";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#bac2de";
        };
        bright = {
          black = "#82859a";
          red = "#ffb5d2";
          green = "#d0ffcb";
          yellow = "#ffffd9";
          blue = "#b3deff";
          magenta = "#ffecff";
          cyan = "#beffff";
          white = "#e4ecff";
        };
        dim = {
          black = "#2e3146";
          red = "#c9617e";
          green = "#7cb977";
          yellow = "#cfb885";
          blue = "#5f8ad0";
          magenta = "#cb98bd";
          cyan = "#6ab8ab";
          white = "#9098b4";
        };
        indexed_colors = [
          {
            index = 16;
            color = "#fab387";
          }
          {
            index = 17;
            color = "#f5e0dc";
          }
        ];
      };
    };
  };
}
