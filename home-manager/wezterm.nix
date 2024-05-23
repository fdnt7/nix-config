{
  inputs,
  pkgs,
  ...
}: {
  programs.wezterm = {
    enable = false;
    package = inputs.wezterm.packages.${pkgs.system}.default;
    extraConfig = ''
      return {
        font = wezterm.font("JetBrainsMono Nerd Font"),
        font_size = 11,
        tab_bar_at_bottom = true,
        hide_tab_bar_if_only_one_tab = true,
        window_background_opacity = 0.67,
        color_scheme = 'Catppuccin Macchiato (Gogh)',
        bold_brightens_ansi_colors = false,
      }
    '';
  };
}
