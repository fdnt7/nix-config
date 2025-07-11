{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nur.modules.homeManager.default];
  home.packages = [pkgs.nur.repos.nltch.spotify-adblock];
}
