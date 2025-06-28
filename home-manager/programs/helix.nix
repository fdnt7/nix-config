{pkgs, ...}: {
  programs.helix = {
    enable = true;
    package = pkgs.evil-helix;
    themes = {
      catppuccin_mocha_transparent = {
        inherits = "catppuccin_mocha";
        "ui.background" = {};
      };
    };
    settings = {
      theme = "catppuccin_mocha_transparent";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        end-of-line-diagnostics = "hint";
        inline-diagnostics = {
          cursor-line = "warning";
        };
      };
    };
  };
}
