{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    neovim

    gcc
    gdb
    python314
    cmake
    gnumake
    unzip
    rustup
    javascript-typescript-langserver

    git
    gh
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
    gammastep

    telegram-desktop
    signal-desktop
    steam
    steam-run
    _1password-cli
    _1password-gui

    brightnessctl
    supergfxctl

    bluez
    home-manager

  ];
}
