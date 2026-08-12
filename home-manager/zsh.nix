{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      n = "nvim";
      l = "ls -l";
      la = "ls -la";
      rm = "trash-put";
      rebuild = "sudo nixos-rebuild switch --flake /home/norker/nixos-config#norker-nixos --show-trace && home-manager switch -b old --flake /home/norker/nixos-config#norker --impure";
      nrebuild = "sudo nixos-rebuild switch --flake /home/norker/nixos-config#norker-nixos --show-trace";
      hrebuild = "home-manager switch -b old --flake /home/norker/nixos-config#norker";
      config = "nvim /home/norker/nixos-config/nixos/configuration.nix";
      hconfig = "nvim /home/norker/nixos-config/home-manager/home.nix";
      install = "nvim /home/norker/nixos-config/nixos/packages.nix";
      screenshot-c = "grim -g '$(slurp)' - | wl-copy";
      screenshot = "grim -g '$(slurp)'";
      please = "sudo";

    };

    history.size = 10000;
    # enable powerlevel10k
    initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };

  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [
      "git"
      "sudo"
    ];
    custom = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;

    # Optional: makes `cd foo` use zoxide behavior.
    # Without this, use `z foo`.
    options = [
      "--cmd cd"
    ];
  };
}
