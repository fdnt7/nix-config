{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitLab {
    domain = "invent.kde.org";
    owner = "plasma";
    repo = "plasma-desktop";
    rev = "a2f5009125cce49e322c86441994ba5e653dcfd2";
    sha256 = "12q57y432mk0mp5pabjmmxiqrplhindqr1hmy5iwccwhmpsa1rd0";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./sddm-theme/* $out/
  '';
}
