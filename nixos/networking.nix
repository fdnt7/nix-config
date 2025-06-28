{...}: {
  #  services.resolved = {
  #    enable = true;
  #    dnssec = "true";
  #    domains = ["~."];
  #    fallbackDns = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
  #    dnsovertls = "true";
  #  };

  networking = {
    hostName = "cuties-only";
    networkmanager = {
      enable = true;
      #dns = "default";
    };
    # nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };
}
