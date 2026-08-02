{ config, pkgs, ... }:

{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./theme.nix
    ./plugins.nix
    # ./debugger.nix
    ./lsp.nix
    ./which-key.nix
  ];

  programs.nixvim = {
    enable = true;

    globals.mapleader = " ";
    globals.maplocalleader = " ";
  };
}
