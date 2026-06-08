{ config, packages, ... }:

{
  programs.tmux = {
    enable = true;
    prefix = "C-Space";

    baseIndex = 1;
    keyMode = "vi";

    extraConfig = ''
      set -g renumber-windows on
      setw -g pane-base-index 1
    '';
  };
}
