{ config, pkgs, ... }:

{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>w";
        action = "<cmd>w<CR>";
        options.desc = "Write file";
      }

      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>q<CR>";
        options.desc = "Quit file";
      }

      {
        mode = "n";
        key = "<leader>/";
        action = "gcc";
        options.desc = "Toggle comment line";
        options.remap = true;
      }

      {
        mode = "v";
        key = "<leader>/";
        action = "gc";
        options.desc = "Toggle comment selection";
        options.remap = true;
      }
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
