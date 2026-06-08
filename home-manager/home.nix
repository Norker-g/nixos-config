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
  ];

  home = {
    username = "norker";
    homeDirectory = "/home/norker";
    stateVersion = "25.11";
  };

}
