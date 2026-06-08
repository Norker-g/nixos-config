{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;

    font = {
      package = pkgs.nerd-fonts.hack;
      name = "Hack Nerd Font";
      size = 12;
    };
    settings = {
      dynamic_background_opacity = true;
      background_opacity = 0.85;
    };
    themeFile = "Nord";
  };
}
