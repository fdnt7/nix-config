{pkgs, ...}: {
  users.users = {
    fdnt = {
      isNormalUser = true;
      description = "Fridella";
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = ["wheel" "networkmanager" "input" "video"];
      shell = pkgs.fish;
    };
  };
}
