{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  systemd,
}:
stdenv.mkDerivation rec {
  pname = "runapp";
  version = "af4af9bcbb82a13d8b47acf37ba21ab4361ce53a";

  src = fetchFromGitHub {
    owner = "c4rlo";
    repo = "runapp";
    rev = version;
    sha256 = "sha256-Aj9UZ09M2zi7kEtdJROGrYlwBGbv7fMjQov98lMhp9c=";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    systemd
  ];

  # Disable hardening to fix _FORTIFY_SOURCE errors
  hardeningDisable = ["fortify"];

  # Remove -march=native which is not allowed in Nix builds
  preBuild = ''
    substituteInPlace Makefile --replace "-march=native" ""
  '';

  # Use the release build instead of debug to avoid potential issues
  buildPhase = ''
    make release
  '';

  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 build_release/runapp $out/bin/runapp
  '';

  makeFlags = ["PREFIX=$(out)"];

  meta = with lib; {
    description = "Application runner for Linux desktop environments that integrate with systemd";
    homepage = "https://github.com/c4rlo/runapp";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [fdnt7];
    mainProgram = "runapp";
  };
}
