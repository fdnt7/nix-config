{pkgs}: let
  pname = "mscore";
  version = "4.5.0";
  src = pkgs.fetchurl {
    url = "https://github.com/musescore/MuseScore/releases/download/v4.5/MuseScore-Studio-4.5.0.250721848-x86_64.AppImage";
    hash = "sha256-rK1mcoarmetliOk3BPfMdI5/OBis0Tub33DHiBUpSDc=";
  };
  appimageContents = pkgs.appimageTools.extractType2 {inherit pname version src;};
in
  pkgs.appimageTools.wrapType2 {
    inherit pname version src;

    extraInstallCommands = ''
      install -Dm444 ${appimageContents}/share/applications/org.musescore.MuseScore4portable.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/org.musescore.MuseScore4portable.desktop \
        --replace-fail 'Exec=mscore4portable %U' 'Exec=${pname}'
      cp -r ${appimageContents}/share/icons $out/share
    '';
  }
