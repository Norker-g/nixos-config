{ config, pkgs, ... }:

{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Ex<CR>";
        options = {
          desc = "Open netrw explorer";
          silent = true;
        };
      }

      {
        mode = "n";
        key = "<leader>vx";
        action = "<cmd>Vex<CR>";
        options = {
          desc = "Open netrw vertical split";
          silent = true;
        };
      }

      {
        mode = "n";
        key = "<leader>sx";
        action = "<cmd>Sex<CR>";
        options = {
          desc = "Open netrw horizontal split";
          silent = true;
        };
      }
    ];
  };
}
