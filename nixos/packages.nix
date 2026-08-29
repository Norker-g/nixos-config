{
  config,
  pkgs,
  inputs,
  ...
}:

# let
#   bluezPkgs =
#     import
#       (builtins.fetchTarball {
#         url = "https://releases.nixos.org/nixos/24.05/nixos-24.05.6632.c21b77913ea8/nixexprs.tar.xz";
#         sha256 = "132w53yp85aki32nhc4dhxm9cxlzvz96fgh5islks28kjal9ysy9";
#       })
#       {
#         system = pkgs.system;
#         config.allowUnfree = true;
#       };
# in
let
  kotlinPkgs = inputs.nixpkgs-kotlin.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  # hardware.bluetooth.package = bluezPkgs.bluez;

  environment.systemPackages = with pkgs; [
    #editors
    vim
    neovim
    tmux
    jetbrains.idea

    # programming related utilities
    gcc
    gdb
    python314
    javacc
    # jdk25
    jdk21
    jdt-language-server
    kotlinPkgs.kotlin
    pkgs.ktlint
    kotlin-language-server
    rustup
    ghc
    binutils

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
    usbutils
    psmisc
    gradle

    # terminal and nix utilities
    fastfetch
    fd
    ripgrep
    fzf
    zoxide
    nix-search-cli
    htop
    btop
    trash-cli
    lsof
    wine64
    timer
    gocryptfs
    speedtest

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
    discord

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
    prismlauncher
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

    #vpn
    openvpn
  ];
  # ++ [
  #   bluezPkgs.bluez
  # ];

}
