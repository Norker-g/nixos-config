{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;

      servers = {
        # Nix
        nil_ls.enable = true;

        # Lua / Neovim config
        lua_ls.enable = true;

        # Bash
        bashls.enable = true;
      };

      keymaps = {
        diagnostic = {
          "<leader>dn" = "goto_next";
          "<leader>dp" = "goto_prev";
          "<leader>de" = "open_float";
          "<leader>dq" = "setloclist";
        };

        lspBuf = {
          "gd" = "definition";
          "gD" = "declaration";
          "gr" = "references";
          "gi" = "implementation";
          "K" = "hover";
          "<leader>rn" = "rename";
          "<leader>ca" = "code_action";
        };
      };
    };

    diagnostic.settings = {
      virtual_text = true;
      signs = true;
      underline = true;
      update_in_insert = false;
      severity_sort = true;
    };
  };
}
