{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [inputs.nixvim.homeModules.nixvim];
  programs.nixvim = {
    enable = true;
    #package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    opts = {
      number = true;
      relativenumber = true;
      termguicolors = true;
      shiftwidth = 2;
      textwidth = 70;
    };

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        transparent_background = true;
        flavour = "mocha";
      };
    };

    plugins = {
      bufferline = {
        enable = true;
      };

      lualine = {
        enable = true;
      };

      lsp = {
        enable = true;
        servers = {
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          nixd.enable = true;
          #jsonls.enable = true;
          pyright = {
            enable = true;
            settings = {
              #pyright = {
              #  disableOrganizeImports = true;
              #};
              python.analysis = {
                #ignore = ["*"];
                typeCheckingMode = "strict";
              };
            };
          };
          ruff = {
            enable = true;
          };

          #cssls.enable = true;

          lua_ls.enable = true;

          clangd.enable = true;
        };
      };

      web-devicons.enable = true;
      telescope.enable = true;
      oil.enable = true;
      treesitter.enable = true;
      luasnip.enable = true;
      neocord = {
        enable = false;
        settings = {
          editing_text = "✏️ %s";
          reading_text = "🔎 %s";
          termiinal = "⌨️ Terminal";
          workspace_text = "🗃️ %s";
        };
      };

      presence-nvim = {
        enable = true;
        editingText = "✏️ %s";
        fileExplorerText = "📂 %s";
        gitCommitText = "✅ Committing Changes";
        pluginManagerText = "🧩 Managing Plugins";
        readingText = "🔎 %s";
        workspaceText = "🗃️ %s";
        mainImage = "file";
        neovimImageText = "E-girl's Code Editor";
      };

      colorizer = {
        enable = true;
        settings.user_default_options = {
          RRGGBBAA = true;
          rgb_fn = true;
          hsl_fn = true;
          css = true;
          css_fn = true;
        };
      };

      cmp = {
        enable = true;
        settings = {
          sources = [
            {name = "nvim_lsp";}
            {name = "path";}
            {name = "buffer";}
            {name = "luasnip";}
          ];

          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
        };
      };

      wakatime.enable = true;

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            bash = [
              "shellcheck"
              "shellharden"
              "shfmt"
            ];
            cpp = ["clang_format"];
            "_" = [
              "squeeze_blanks"
              "trim_whitespace"
              "trim_newlines"
            ];
            python = ["ruff format"];
          };
          format_on_save = {
            lsp_format = "fallback";
            timeout_ms = 500;
          };
          format_after_save = {
            lsp_format = "fallback";
          };
          log_level = "warn";
          notify_on_error = false;
          notify_no_formatters = false;
          formatters = {
            shellcheck = {
              command = lib.getExe pkgs.shellcheck;
            };
            shfmt = {
              command = lib.getExe pkgs.shfmt;
            };
            shellharden = {
              command = lib.getExe pkgs.shellharden;
            };
            squeeze_blanks = {
              command = lib.getExe' pkgs.coreutils "cat";
            };
          };
        };
      };

      tiny-inline-diagnostic = {
        enable = true;
        settings = {multilines.enabled = true;};
      };
    };
    autoCmd = [
      #{
      #  command = "!clang++ -Wall %";
      #  event = ["BufWritePost"];
      #  pattern = ["*.cpp"];
      #}
    ];
  };
}
