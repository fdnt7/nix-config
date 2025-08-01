{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    inputs.tsutsumi.packages.${pkgs.system}.wakatime-ls
    (pkgs.callPackage ./discord-presence.nix {})
  ];
  programs.zed-editor = {
    enable = true;
    #package = (pkgs.zed-editor.fhsWithPackages (pkgs: [pkgs.zlib pkgs.pkg-config pkgs.openssl]));
    extensions = ["wakatime" "discord-presence" "catppuccin-blur" "sql" "nix" "rose-pine-theme"];

    userKeymaps = [
      {
        context = "Workspace";
        bindings = {
          # "shift shift": "file_finder::Toggle"
        };
      }
      {
        context = "Editor";
        bindings = {
          # "j k": ["workspace::SendKeystrokes" "escape"]
        };
      }
    ];

    # Zed settings
    #
    # For information on how to configure Zed, see the Zed
    # documentation: https://zed.dev/docs/configuring-zed
    #
    # To see all of Zed's default settings without changing your
    # custom settings, run `zed: open default settings` from the
    # command palette (cmd-shift-p / ctrl-shift-p)
    userSettings = {
      collaboration_panel = {
        dock = "right";
      };
      outline_panel = {
        dock = "right";
      };
      project_panel = {
        dock = "right";
      };
      theme = "Catppuccin Mocha (Blue Blur+)";
      ui_font_size = 16;
      buffer_font_size = 12;
      buffer_font_family = "JetBrainsMono Nerd Font";
      vim_mode = true;
      relative_line_numbers = true;
      lsp = {
        rust-analyzer = {
          binary = {path_lookup = true;};
          initialization_options = {
            check = {
              command = "clippy";
            };
            cargo = {
              features = "all";
            };
          };
        };
      };
      diagnostics = {
        inline = {
          enabled = true;
        };
      };
    };
  };
}
