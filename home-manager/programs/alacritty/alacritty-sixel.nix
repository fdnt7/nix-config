# heavily based on:
# https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/al/alacritty/package.nix
{
  stdenv,
  lib,
  fetchFromGitHub,
  rustPlatform,
  nixosTests,
  cmake,
  installShellFiles,
  makeWrapper,
  ncurses,
  pkg-config,
  python3,
  scdoc,
  expat,
  fontconfig,
  freetype,
  libGL,
  xorg,
  libxkbcommon,
  wayland,
  xdg-utils,
  nix-update-script,
}: let
  rpathLibs =
    [
      expat
      fontconfig
      freetype
    ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [
      libGL
      xorg.libX11
      xorg.libXcursor
      xorg.libXi
      xorg.libXxf86vm
      xorg.libxcb
      libxkbcommon
      wayland
    ];
in
  rustPlatform.buildRustPackage rec {
    pname = "alacritty";
    version = "0.15.0-graphics";

    src = fetchFromGitHub {
      owner = "ayosec";
      repo = "alacritty";
      tag = "v${version}";
      hash = "sha256-vDpmjlH2UBsRf2JkyN79gWESIEIfqe+RTGWrzJW+yXM=";
    };

    cargoHash = "sha256-O2AsRpE+B1ATfUCAWDwsa32L/MOxYH39r3OGKUePoMA=";

    nativeBuildInputs = [
      cmake
      installShellFiles
      makeWrapper
      ncurses
      pkg-config
      python3
      scdoc
    ];

    buildInputs = rpathLibs;

    outputs = [
      "out"
      "terminfo"
    ];

    postPatch = lib.optionalString stdenv.hostPlatform.isLinux ''
      substituteInPlace alacritty/src/config/ui_config.rs \
        --replace xdg-open ${xdg-utils}/bin/xdg-open
    '';

    checkFlags = ["--skip=term::test::mock_term"]; # broken on aarch64

    postInstall =
      (
        if stdenv.hostPlatform.isDarwin
        then ''
          mkdir $out/Applications
          cp -r extra/osx/Alacritty.app $out/Applications
          ln -s $out/bin $out/Applications/Alacritty.app/Contents/MacOS
        ''
        else ''
          install -D extra/linux/Alacritty.desktop -t $out/share/applications/
          install -D extra/linux/org.alacritty.Alacritty.appdata.xml -t $out/share/appdata/
          install -D extra/logo/compat/alacritty-term.svg $out/share/icons/hicolor/scalable/apps/Alacritty.svg

          # patchelf generates an ELF that binutils' "strip" doesn't like:
          #    strip: not enough room for program headers, try linking with -N
          # As a workaround, strip manually before running patchelf.
          $STRIP -S $out/bin/alacritty

          patchelf --add-rpath "${lib.makeLibraryPath rpathLibs}" $out/bin/alacritty
        ''
      )
      + ''
        installShellCompletion --zsh extra/completions/_alacritty
        installShellCompletion --bash extra/completions/alacritty.bash
        installShellCompletion --fish extra/completions/alacritty.fish

        install -dm 755 "$out/share/man/man1"
        install -dm 755 "$out/share/man/man5"

        scdoc < extra/man/alacritty.1.scd | gzip -c > $out/share/man/man1/alacritty.1.gz
        scdoc < extra/man/alacritty-msg.1.scd | gzip -c > $out/share/man/man1/alacritty-msg.1.gz
        scdoc < extra/man/alacritty.5.scd | gzip -c > $out/share/man/man5/alacritty.5.gz
        scdoc < extra/man/alacritty-bindings.5.scd | gzip -c > $out/share/man/man5/alacritty-bindings.5.gz

        install -dm 755 "$terminfo/share/terminfo/a/"
        tic -xe alacritty,alacritty-direct -o "$terminfo/share/terminfo" extra/alacritty.info
        mkdir -p $out/nix-support
        echo "$terminfo" >> $out/nix-support/propagated-user-env-packages
      '';

    dontPatchELF = true;

    passthru = {
      tests.test = nixosTests.terminal-emulators.alacritty;
      updateScript = nix-update-script {};
    };

    meta = with lib; {
      description = "Cross-platform, GPU-accelerated terminal emulator";
      homepage = "https://github.com/alacritty/alacritty";
      license = licenses.asl20;
      mainProgram = "alacritty";
      maintainers = with maintainers; [
        Br1ght0ne
        rvdp
      ];
      platforms = platforms.unix;
      changelog = "https://github.com/alacritty/alacritty/blob/v${version}/CHANGELOG.md";
    };
  }
