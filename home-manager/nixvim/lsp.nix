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

        clangd.enable = true;

        pyright.enable = true;

        ts_ls.enable = true;
        ts_ls.filetypes = [
          "javascript"
            "javascriptreact"
            "typescript"
            "typescriptreact"
        ];

        # Rust
        rust_analyzer = {
          enable = true;

          installCargo = true;
          installRustc = true;
          installRustfmt = true;

          settings = {
            "rust-analyzer" = {
              check = {
                command = "clippy";
              };
            };
          };
        };
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
