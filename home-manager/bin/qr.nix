{pkgs}: let
  NOTIFY-SEND = "${pkgs.libnotify}/bin/notify-send";
  GRIMBLAST = "${pkgs.grimblast}/bin/grimblast";
  ZBARIMG = "${pkgs.zbar}/bin/zbarimg";
in
  pkgs.writeShellScriptBin "qr" ''
    set -u

    tmp="$(mktemp --suffix=.png)"
    trap 'rm -f "$tmp"' EXIT

    # Take area screenshot
    if ! ${GRIMBLAST} save area "$tmp"; then
      exit 1
    fi

    # Try to decode a QR and copy it
    if decoded="$(${ZBARIMG} -q "$tmp" | cut -d: -f2-)"; then
      if [ -n "$decoded" ]; then
        printf '%s' "$decoded" | wl-copy
        ${NOTIFY-SEND} -u low "QR copied" "$(printf '%s' "$decoded" | head -c 120)"

        # Collect all http/https links (one per line) and open them all
        mapfile -t urls < <(printf '%s\n' "$decoded" | grep -Eo '^https?://\S+')
        if [ "''${#urls[@]}" -gt 0 ]; then
          for url in "''${urls[@]}"; do
            xdg-open "$url" >/dev/null 2>&1 &
          done
        fi
        exit 0
      fi
    fi

    ${NOTIFY-SEND} -u critical "No QR code found"
    exit 2
  ''
