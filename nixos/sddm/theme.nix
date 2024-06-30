{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src =
    pkgs.fetchFromGithub {
    };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}
