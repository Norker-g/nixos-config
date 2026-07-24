# configuration.nix or a separate fonts.nix module
{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    dejavu_fonts
  ];
}
