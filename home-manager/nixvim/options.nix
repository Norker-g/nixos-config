{ config, pkgs, ... }:

{
  programs.nixvim = {
    opts = {
      # Line numbers
      number = true;
      relativenumber = true;

      # System clipboard
      clipboard = "unnamedplus";

      # Default indentation.
      # guess-indent can override this per file.
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;
      smartindent = true;

      # Search
      ignorecase = true;
      smartcase = true;

      # UI
      termguicolors = true;
      signcolumn = "yes";
      cursorline = true;
      scrolloff = 8;

      # Popup/floating-window transparency.
      # 10 = roughly 90% opaque.
      winblend = 10;
      pumblend = 10;

      # Swap/recovery files
      swapfile = true;
      directory = [ "~/.local/state/nvim/swap//" ];

      # Persistent undo: undo/redo after closing Neovim
      undofile = true;
      undodir = "~/.local/state/nvim/undo//";

      # Backup files
      backup = true;
      backupdir = [ "~/.local/state/nvim/backup//" ];

      # Better LSP update behavior
      updatetime = 250;
    };

    extraConfigLuaPre = ''
      vim.fn.mkdir(vim.fn.expand("~/.local/state/nvim/swap"), "p")
      vim.fn.mkdir(vim.fn.expand("~/.local/state/nvim/undo"), "p")
      vim.fn.mkdir(vim.fn.expand("~/.local/state/nvim/backup"), "p")
    '';

    extraConfigLua = ''
      vim.api.nvim_create_autocmd("TextYankPost", {
          desc = "Highlight yanked text",
          group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
          callback = function()
          vim.highlight.on_yank({ timeout = 200 })
          end,
          })
    '';
  };
}
