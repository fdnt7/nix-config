{pkgs}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "discord-presence-lsp";
  version = "200ae73131a098516025e4fd5269d8c8cb6144f6";
  useFetchCargoVendor = true;
  cargoHash = "sha256-2hQHhrbUYKDtFX8ZiDpVYrd9/g6bCi9XL0VwKDWFE+s=";

  src = pkgs.fetchFromGitHub {
    owner = "xhyrom";
    repo = "zed-discord-presence";
    rev = version;
    hash = "sha256-6KpjJajibMY7pBR5XhZf2KPBkBMkdcYKutifNdF3Hko=";
  };

  cargoBuildFlags = "--package discord-presence-lsp";
}
