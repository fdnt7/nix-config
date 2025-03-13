{pkgs}:
pkgs.stdenv.mkDerivation {
  pname = "thsarabunnew";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://www.f0nt.com/?dl_name=sipafonts/THSarabunNew.zip";
    sha256 = "sha256-ej23MuR1sLitsQrfQFjn2BYezvFX9W+XEcIpxzvtxZI=";
  };

  nativeBuildInputs = [pkgs.unzip];

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    unzip $src -d extracted
    mv extracted/*.ttf $out/share/fonts/truetype/
  '';
}
