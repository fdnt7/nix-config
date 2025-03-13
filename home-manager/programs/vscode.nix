{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      # rust-lang.rust-analyzer ## broken
      usernamehw.errorlens
      eamodio.gitlens
      wakatime.vscode-wakatime
      github.vscode-pull-request-github
      serayuzgur.crates
      tamasfe.even-better-toml
    ];
  };
}
