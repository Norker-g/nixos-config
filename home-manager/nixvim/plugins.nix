{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      web-devicons = {
        enable = true;
      };
      # Syntax highlighting
      treesitter = {
        enable = true;
      };

      # Automatic tab size / indentation recognition
      guess-indent = {
        enable = true;
      };

      # Auto-complete brackets, parentheses, quotes, etc.
      nvim-autopairs = {
        enable = true;
      };

      comment = {
        enable = true;
      };

      # Telescope fuzzy finder
      telescope = {
        enable = true;

        keymaps = {
          "<leader>ff" = {
            action = "find_files";
            options.desc = "Find files";
          };

          "<leader>fg" = {
            action = "live_grep";
            options.desc = "Live grep";
          };

          "<leader>fb" = {
            action = "buffers";
            options.desc = "Find buffers";
          };

          "<leader>fh" = {
            action = "help_tags";
            options.desc = "Help tags";
          };
        };
      };

      # Autocompletion (nvim-cmp)
      cmp = {
        enable = true;
        autoEnableSources = true;

        settings = {
          snippet = {
            expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          };

          preselect = "cmp.PreselectMode.Item";   # ← new: auto‑select first item
            max_item_count = 6;                     # ← new: restrict visible results

            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-e>" = "cmp.mapping.abort()";
              "<CR>" = "cmp.mapping.confirm({ select = true })";

              "<Tab>" = ''
                function(fallback)
                if require('cmp').visible() then
                  require('cmp').confirm({ select = true, behavior = require('cmp').ConfirmBehavior.Insert })
                else
                  fallback()
                    end
                    end
                    '';

              "<C-n>" = "cmp.mapping.select_next_item({ behavior = 'insert' })";
              "<C-p>" = "cmp.mapping.select_prev_item({ behavior = 'insert' })";
              "<Down>" = "cmp.mapping.select_next_item({ behavior = 'insert' })";
              "<Up>" = "cmp.mapping.select_prev_item({ behavior = 'insert' })";

              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            };

          sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "path"; }
          { name = "nvim_lua"; }
          ];
        };
      };
    };

    # Extra plugins required by cmp
    extraPlugins = with pkgs.vimPlugins; [
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-nvim-lua
      luasnip
      cmp_luasnip
    ];
  };
}
