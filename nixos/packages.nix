{ config, pkgs, ... }:

let
  bluezPkgs =
    import
      (builtins.fetchTarball {
        url = "https://releases.nixos.org/nixos/24.05/nixos-24.05.6632.c21b77913ea8/nixexprs.tar.xz";
        sha256 = "132w53yp85aki32nhc4dhxm9cxlzvz96fgh5islks28kjal9ysy9";
      })
      {
        system = pkgs.system;
        config.allowUnfree = true;
      };
in
{
  hardware.bluetooth.package = bluezPkgs.bluez;

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
    kotlin
    kotlin-language-server
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
    home-manager
    bluez
    pavucontrol
    blueman

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
    chessx
    chess-tui
    #
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
  # ++ [
  #   bluezPkgs.bluez
  # ];

}
