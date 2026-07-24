{ config, packages, ... }:

{
  programs.tmux = {
    enable = true;
    prefix = "C-Space";
    terminal = "tmux-256color";
    baseIndex = 1;

    extraConfig = ''
      set -g renumber-windows on
      setw -g pane-base-index 1
    '';
  };
}
