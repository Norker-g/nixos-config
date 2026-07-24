{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    #editors
    vim
    neovim
    tmux

    # programming related utilities
    gcc
    gdb
    python314
    javacc
    jdk25
    jdt-language-server
    rustup
    ghc

    cmake
    stack
    gnumake
    unzip
    javascript-typescript-langserver
    links2
    git
    gh
    lazygit
    # toybox
    coreutils
    psmisc
    gradle

    # terminal and nix utilities
    fastfetch
    fd
    ripgrep
    zoxide
    nix-search-cli
    htop
    btop
    trash-cli
    lsof
    wine64
    timer
    gocryptfs

    # The shell
    zsh
    zsh-powerlevel10k
    oh-my-zsh
    nerd-fonts.hack

    # WM related stuff
    ly
    hyprland
    waybar
    hyprshot
    grim
    slurp
    quickshell
    hyprpaper
    wl-clipboard
    kitty
    rofi
    gammastep

    # device managment
    brightnessctl
    supergfxctl
    pipewire
    bluez
    home-manager

    #big applications:
    telegram-desktop
    signal-desktop
    steam
    steam-run
    _1password-cli
    _1password-gui
    keymapp
    brave
    shotcut
    codex

    # games
    openttd

    # for remote connection
    tailscale
    ttyd
    caddy

    # for streaming
    obs-studio
    vlc

    # for graphomata
    # xdg-utils # xdg-open
    zenity # graphical dialogs
    openssl
    cacert # CA certificate bundle
  ];
}
