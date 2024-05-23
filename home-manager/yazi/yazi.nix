{
  inputs,
  pkgs,
  ...
}:
# let
#   starship = pkgs.fetchFromGitHub {
#     owner = "Rolv-Apneseth";
#     repo = "starship.yazi";
#     rev = "6197e4c";
#     hash = "sha256-oHoBq7BESjGeKsaBnDt0TXV78ggGCdYndLpcwwQ8Zts=";
#   };
# in
{
  xdg.configFile = {
    "yazi/init.lua".source = ./init.lua;
    #    "yazi/plugins/starship.yazi".source = "${starship}";
  };
  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.system}.default;
    enableFishIntegration = true;
    settings = {
      manager = {
        show_symlink = false;
        show_hidden = true;
      };
    };
    theme = fromTOML (builtins.readFile ./theme.toml);
  };
}
