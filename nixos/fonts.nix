{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      dejavu_fonts
      freefont_ttf
      gyre-fonts
      liberation_ttf
      unifont
      #noto-fonts-color-emoji

      noto-fonts
      noto-fonts-cjk
      twemoji-color-font
      ubuntu_font_family
      #tlwg
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
        ];
      })
    ];

    fontconfig = {
      defaultFonts = {
        emoji = [
          "Segoe UI Emoji"
          "Twitter Color Emoji"
        ];
        serif = ["Noto Serif" "Noto Serif Thai"];
        sansSerif = ["Noto Sans" "Noto Sans Thai"];
        monospace = ["JetBrainsMono Nerd Font" "Tlwg Typewriter"];
      };
    };
  };
}
