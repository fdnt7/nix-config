{pkgs}: let
  MULLVAD = "${pkgs.mullvad}/bin/mullvad";
in
  pkgs.writeShellScriptBin "vpn" ''
    #!/bin/bash

    status=$(${MULLVAD} status | head -1)

    if [[ "$status" == "Connected"* ]]; then
        echo "Currently connected. Disconnecting..."
        ${MULLVAD} disconnect
    elif [[ "$status" == "Disconnected"* ]]; then
        echo "Currently disconnected. Connecting..."
        ${MULLVAD} connect
    else
        echo "Unknown status: $status"
        exit 1
    fi
  ''
