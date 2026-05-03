{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    neovim

    gcc
    python314
    cmake
    gnumake
    unzip
    rustup

    git
    lazygit
    fastfetch
    fd
    ripgrep
    zoxide
    nix-search-cli
    htop
    btop

    keymapp

    zsh
    zsh-powerlevel10k
    oh-my-zsh
    nerd-fonts.hack

    ly
    hyprland
    waybar
    hyprshot
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
