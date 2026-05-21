{ config, pkgs, ... }:
{

  home = {
    username = "norker";
    homeDirectory = "/home/norker";
    stateVersion = "25.11";
  };

  imports = [
    ./zsh.nix
    ./kitty.nix
    ./hypr.nix
    ./gammastep.nix
    ./nixvim
    ./themes.nix
  ];
}
