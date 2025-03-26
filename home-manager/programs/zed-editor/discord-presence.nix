{pkgs}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "discord-presence-lsp";
  version = "d20b977600423f0d20a5b09f5c05e63f83333c1c";
  useFetchCargoVendor = true;
  cargoHash = "sha256-JLNCEeo9fKeV4vTtPs+Yj2wRO1RKP2fuetrPlXcPBjA=";

  src = pkgs.fetchFromGitHub {
    owner = "xhyrom";
    repo = "zed-discord-presence";
    rev = version;
    hash = "sha256-JGuWVwKjRxg+4lBlBxggiNioSfOL19WWHE5SYNUPTtk=";
  };

  cargoBuildFlags = "--package discord-presence-lsp";
}
