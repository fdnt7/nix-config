{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "avivace";
    repo = "breeze2-sddm-theme";
    rev = "8087fa6f9826f51a766c48b59ce1c06c323a3540";
    sha256 = "1gjb870kdj2ygm1fzdqznc7znyx9cyrdlm7facik43m6vq9nid8a";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}
