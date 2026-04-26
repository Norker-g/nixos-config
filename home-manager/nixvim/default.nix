{ config, pkgs, ... }:

{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./theme.nix
    ./plugins.nix
    ./lsp.nix
    ./which-key.nix
  ];

  programs.nixvim = {
    enable = true;

    globals.mapleader = " ";
    globals.maplocalleader = " ";
  };
}
