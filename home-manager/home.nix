{ config, pkgs, ... }:
{
  imports = [
    ./gammastep.nix
    ./hypr.nix
    ./kitty.nix
    ./nixvim
    ./themes.nix
    ./zsh.nix
    ./tmux.nix
    ./browser.nix
  ];

  home = {
    username = "norker";
    homeDirectory = "/home/norker";
    stateVersion = "25.11";

    file.".config/quickshell/nordbar/shell.qml".source = ./nordbar/shell.qml;

    file.".config/quickshell/nordbar/scripts/status.sh" = {
      source = ./nordbar/scripts/status.sh;
      executable = true;
    };
  };
}
