{config, ...}: {
  programs.zsh = {
    enable = false;
    enableCompletion = true;
    enableVteIntegration = true;
    autocd = true;
    dotDir = "${config.xdg.configHome}/zsh";
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    shellAliases = {};
    syntaxHighlighting.enable = true;
    zsh-abbr = {
      enable = true;
      abbreviations = {
        ff = "fastfetch";
      };
    };
  };
}
