{ config, pkgs, ... }:

{
  programs.nixvim = {
    # colorschemes.nord = {
    #   enable = true;
    # };

    # colorschemes.kanagawa = {
    #   enable = true;
    #   settings.theme = "wave";
    # };

    extraPlugins = with pkgs.vimPlugins; [
      nordic-nvim
    ];

    colorscheme = "nordic";

    extraConfigLuaPre = ''
      require("nordic").setup({
        visual = {
          theme = "light",
          blend = 1,
        },
        cursorline = {
          theme = "light"
        },
      })

    '';

    extraConfigLua = ''
        vim.api.nvim_set_hl(0, "StatusLine", { 
          bg = "#434C5E",
            fg = "#D8DEE9",
            })

      vim.api.nvim_set_hl(0, "StatusLineNC", {
          bg = "#3B4252",
          fg = "#4C566A",
          })
         local transparent_groups = {
               "Normal",
               "NormalFloat",
               "SignColumn",
               "LineNr",
               "CursorLineNr",
               "EndOfBuffer",
             }

             for _, group in ipairs(transparent_groups) do
               vim.api.nvim_set_hl(0, group, { bg = "none" })
             end
    '';
  };
}
