{...}: {
  virtualisation.libvirtd = {
    enable = true;
    hooks.qemu = {
      practicum = ./port-forward.sh;
    };
  };
  programs.virt-manager.enable = true;
  networking = {
    firewall.allowedTCPPorts = [59922];
    nat = {
      enable = true;
      internalInterfaces = ["enp0s20u1u1"];
      externalInterface = "virbr0";
      forwardPorts = [
        {
          sourcePort = 59922;
          proto = "tcp";
          destination = "192.168.122.6:22";
        }
      ];
    };
  };

  users.users.fdnt.extraGroups = ["libvirtd"];
}
