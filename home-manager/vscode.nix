{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      rust-lang.rust-analyzer
      usernamehw.errorlens
      eamodio.gitlens
      wakatime.vscode-wakatime
      github.vscode-pull-request-github
      serayuzgur.crates
      tamasfe.even-better-toml
    ];
  };
}
