{
  inputs,
  config,
  ...
}: {
  imports = [inputs.nur.nixosModules.nur];
  home.packages = [config.nur.repos.nltch.spotify-adblock];
}
