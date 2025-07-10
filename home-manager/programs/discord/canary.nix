{
  pkgs,
  #inputs,
  ...
}: {
  #imports = [
  #  inputs.nixcord.homeModules.nixcord
  #];
  #
  #programs.nixcord = {
  #  enable = true;
  #};

  home.packages = [
    (pkgs.discord-canary.override {
      withOpenASAR = true;
      #withVencord = true;
    })
  ];
}
