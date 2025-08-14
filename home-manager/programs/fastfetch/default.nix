{lib, ...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      display = {
        color = "96";
        separator = " ";
      };
      logo = {
        color = {
          "1" = "2;30";
          "2" = "22;30";
          "3" = "22;35";
          "4" = "22;97";
          "5" = "22;34";
        };
        source = "nixos-fdnt";
      };
      modules = [
        {
          color = {
            at = "97";
            host = "94";
            user = "95";
          };
          format = "  {6}{7}{8}";
          type = "title";
        }
        {
          format = "┌─────────────────────────────────────────────────┐";
          type = "custom";
        }
        {
          key = "   ";
          type = "os";
        }
        {
          key = "  󰌢 ";
          type = "host";
        }
        {
          key = "   ";
          type = "kernel";
        }
        {
          key = "   ";
          type = "uptime";
        }
        {
          key = "  󰏖 ";
          type = "packages";
        }
        {
          key = "   ";
          type = "shell";
        }
        {
          key = "  󰍹 ";
          type = "display";
        }
        {
          key = "   ";
          type = "wm";
        }
        {
          key = "   ";
          type = "theme";
        }
        {
          key = "  󰇲 ";
          type = "icons";
        }
        {
          key = "   ";
          type = "terminal";
        }
        {
          key = "   ";
          type = "terminalfont";
        }
        {
          key = "   ";
          type = "cpu";
        }
        {
          key = "  󰾲 ";
          type = "gpu";
        }
        {
          key = "   ";
          type = "memory";
        }
        {
          format = "└─────────────────────────────────────────────────┘";
          type = "custom";
        }
        {
          format = let
            # Escape char. workaround for: https://github.com/NixOS/nix/issues/10082
            E = builtins.fromJSON ''"\u001b"'';

            # A list of the color codes to iterate over
            colors = lib.reverseList (lib.range 0 7);

            # A function that takes a number and returns the formatted color segment string
            formatColorSegment = n: "${E}[3${toString n}m${E}[9${toString n}m";

            # Map the function over the list of colors and concatenate the results
            formattedString = builtins.concatStringsSep " " (builtins.map formatColorSegment colors);
          in
            # Add the leading space to the final string
            "  ${formattedString}";
          type = "custom";
        }
      ];
    };
  };

  xdg = {
    dataFile = {
      "fastfetch/presets".source = ./presets;
      "fastfetch/logos".source = ./logos;
    };
  };
}
