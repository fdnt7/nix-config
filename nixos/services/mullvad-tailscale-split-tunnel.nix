# mullvad-tailscale-split-tunnel.nix
# NixOS module for split tunneling Tailscale through Mullvad VPN
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.mullvad-tailscale-split-tunnel;

  # nftables rules to exclude Tailscale traffic from Mullvad
  mullvadTsRules = ''
    table inet mullvad-ts {
      # Exclude all IPs in range 100.64.0.0 to 100.127.255.255 from Mullvad
      # Similarly for IPv6
      chain outgoing {
        type route hook output priority 0; policy accept;
        ip daddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
        ip6 daddr fd7a:115c:a1e0::/48 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
      }

      # Exclude all traffic coming from tailscale0 from Mullvad
      chain incoming {
        type filter hook input priority -100; policy accept;
        iifname "tailscale0" ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
      }

      # Exclude the Tailscale DNS resolver from Mullvad
      chain excludeDns {
        type filter hook output priority -10; policy accept;
        ip daddr 100.100.100.100 udp dport 53 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
        ip daddr 100.100.100.100 tcp dport 53 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
      }
    }
  '';

  # Cleanup rules to remove the table
  mullvadTsCleanupRules = ''
    table inet mullvad-ts
    delete table inet mullvad-ts
  '';
in {
  options.services.mullvad-tailscale-split-tunnel = {
    enable = mkEnableOption "Mullvad-Tailscale split tunnel";
  };

  config = mkIf cfg.enable {
    # Ensure required services are enabled
    assertions = [
      {
        assertion = config.services.tailscale.enable;
        message = "Tailscale must be enabled for split tunneling to work";
      }
      {
        assertion = config.services.mullvad-vpn.enable;
        message = "Mullvad VPN must be enabled for split tunneling to work";
      }
    ];

    # Enable nftables
    networking.nftables.enable = true;

    # Create the rules files
    environment.etc = {
      "mullvad-ts/mullvad-ts.rules" = {
        text = "#!/usr/sbin/nft -f\n\n" + mullvadTsRules;
        mode = "0755";
      };
      "mullvad-ts/mullvad-ts-cleanup.rules" = {
        text = "#!/usr/sbin/nft -f\n\n" + mullvadTsCleanupRules;
        mode = "0755";
      };
    };

    # Override the tailscaled systemd service to apply nftables rules
    systemd.services.tailscaled = {
      serviceConfig = {
        ExecStartPre = [
          "${pkgs.nftables}/bin/nft -f /etc/mullvad-ts/mullvad-ts.rules"
        ];
        ExecStopPost = [
          "${pkgs.nftables}/bin/nft -f /etc/mullvad-ts/mullvad-ts-cleanup.rules"
        ];
      };
    };

    # Ensure systemd-resolved is configured
    services.resolved = {
      enable = true;
      dnssec = "false"; # Often needed for VPN compatibility
    };

    # Create a symlink for /etc/resolv.conf if not already managed
    environment.etc."resolv.conf".source = mkDefault "/run/systemd/resolve/stub-resolv.conf";
  };
}
