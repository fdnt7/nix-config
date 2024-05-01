{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nixvim.homeManagerModules.nixvim];
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    opts = {
      number = true;
      relativenumber = true;
      termguicolors = true;
      shiftwidth = 2;
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
          rust-analyzer.enable = true;
          nixd.enable = true;
          jsonls.enable = true;
        };
      };
      telescope.enable = true;
      oil.enable = true;
      treesitter.enable = true;
      luasnip.enable = true;
      neocord.enable = true;
      nvim-colorizer = {
        enable = true;
        userDefaultOptions = {
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
        };
      };
    };
    extraPlugins = [pkgs.vimPlugins.vim-wakatime];
  };
}
