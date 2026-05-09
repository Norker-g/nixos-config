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
    javascript-typescript-langserver

    git
    lazygit
    fastfetch
    fd
    ripgrep
    zoxide
    nix-search-cli
    htop
    btop
    trash-cli

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
