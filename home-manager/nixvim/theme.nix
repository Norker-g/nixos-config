{ config, pkgs, ... }:

{
  programs.nixvim = {
    colorschemes.nord = {
      enable = true;
    };

    extraConfigLua = ''
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
