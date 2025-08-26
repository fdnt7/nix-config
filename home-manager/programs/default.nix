{...}: {
  imports = [
    ./home-manager.nix

    ./bat.nix
    ./btop.nix
    ./cava.nix
    ./eza.nix
    ./fd.nix
    ./fish.nix
    ./foot.nix
    ./git.nix
    ./gpg.nix
    ./htop.nix
    ./kitty.nix
    ./helix.nix
    ./mpv.nix
    ./nixvim.nix
    ./obs.nix
    ./rofi.nix
    ./spotify
    ./starship.nix
    ./vscode.nix
    ./wezterm.nix
    ./zsh.nix
    ./nix-index.nix
    ./zen.nix
    ./eww
    ./wob.nix
    ./mako.nix
    ./discord

    ./zed-editor
    ./alacritty
    #./lf/lf.nix # not a module yet
    ./fastfetch
    ./hypr/hypridle.nix
    ./hypr/hyprland
    ./hypr/hyprlock.nix
    ./hypr/hyprsunset.nix
    #./hypr/hyprcursor # not a module yet
    ./swaync
    ./waybar
    ./yazi
    ./uwsm
    ./mullvad-vpn.nix
    ./direnv.nix
  ];
}
