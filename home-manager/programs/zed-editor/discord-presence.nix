{pkgs}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "discord-presence-lsp";
  version = "704c004468bfd1c6c8c2791fd1d1390439a9c27d";
  cargoHash = "sha256-8FR8SnoKWQOXv7hBBjow/tpuPvvJRxV/+yTgDzLAhk0=";

  src = pkgs.fetchFromGitHub {
    owner = "xhyrom";
    repo = "zed-discord-presence";
    rev = version;
    hash = "sha256-eNwfpmuEhQtlcF1edk9hZKKhI5OMK1EbCp5tlJUY+28=";
  };

  cargoBuildFlags = "--package discord-presence-lsp";
}
