{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    neovim

    git
    lazygit
    gcc
    unzip
    fastfetch
    fd
    ripgrep
    zoxide
    nix-search-cli

    zsh
    zsh-powerlevel10k
    oh-my-zsh
    nerd-fonts.hack

    ly
    hyprland
    waybar
    quickshell
    hyprpaper
    wl-clipboard
    kitty
    rofi
    brave

    telegram-desktop
    signal-desktop
    steam 
    steam-run
    _1password-cli
    _1password-gui

    brightnessctl

    bluez
    home-manager
  ];
}
