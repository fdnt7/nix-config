{pkgs}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "discord-presence-lsp";
  version = "8fbf6c68527de3ca54809967e184f1f314034dc9";
  cargoHash = "sha256-D2apZowN+NDcMTLnGDbFUIdiGckFsuUhlrW6an8ZdGE=";

  src = pkgs.fetchFromGitHub {
    owner = "xhyrom";
    repo = "zed-discord-presence";
    rev = version;
    hash = "sha256-0y28W54JZtjGmgrI7A0Ews+GKHK96nX0ejHMuqxjvh4=";
  };

  cargoBuildFlags = "--package discord-presence-lsp";
}
