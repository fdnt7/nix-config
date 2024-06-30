{pkgs}:
pkgs.stdenv.mkDerivation {
  name = pkgs.fetchFromGithub {
    owner = "fdnt7";
    repo = "hyprcursor-theme-kangel";
  };
}
