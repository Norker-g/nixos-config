{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins.which-key = {
      enable = true;

      settings = {
        preset = "modern";

        delay = 300;

        win = {
          border = "rounded";
        };
      };
    };
  };
}
