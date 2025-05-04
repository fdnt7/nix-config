{pkgs, ...}: let
in {
  services = {
    printing = {
      enable = true;
      browsing = true;
      browsedConf = ''
        BrowseDNSSDSubTypes _ipp,_print           # pick up IPP printers and legacy print services
        BrowseLocalProtocols all
        BrowseRemoteProtocols all
        CreateIPPPrinterQueues All                # auto-create queues for all discovered printers
        BrowseProtocols all
      '';
      drivers = [(pkgs.callPackage ./dcpt500w.nix {}).driver (pkgs.callPackage ./dcpt500w.nix {}).cupswrapper];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
  hardware.printers = {
    ensureDefaultPrinter = "DCP-T500W";
    ensurePrinters = [
      {
        deviceUri = "ipp://192.168.1.52:631/ipp/print";
        model = "brother_dcpt500w_printer_en.ppd";
        description = "Home Printer #1";
        location = "Home";
        name = "DCP-T500W";
      }
    ];
  };
}
