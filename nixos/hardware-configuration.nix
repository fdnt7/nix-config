# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "thunderbolt" "usbhid"];
      kernelModules = [];
    };
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/F0C1-A424";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    "/" = {
      device = "/dev/disk/by-uuid/82c34290-b251-4a23-bdbd-c9553b7b525f";
      fsType = "btrfs";
      options = ["subvol=@"];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/b51b8986-fca8-46a4-ad65-6246d08fd396";
      fsType = "btrfs";
    };

    "/mnt/win" = {
      device = "/dev/disk/by-uuid/6E22B4D422B4A30F";
      fsType = "ntfs-3g";
      options = ["rw" "uid=1000" "fmask=117" "dmask=007"];
    };

    "/mnt/store" = {
      device = "/dev/disk/by-uuid/78C68019C67FD63A";
      fsType = "ntfs-3g";
      options = ["rw" "uid=1000" "fmask=117" "dmask=007"];
    };
  };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp6s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  services.xserver.videoDrivers = ["amdgpu"];
}
