{ pkgs, inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.beta
    # or inputs.zen-browser.homeModules.twilight
  ];

  home.packages = with pkgs; [
    inter
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    profiles.default = {
      name = "Default";
      isDefault = true;

      settings = {
        # Default webpage fonts
        "font.default.x-western" = "sans-serif";
        "font.name.serif.x-western" = "Inter";
        "font.name.sans-serif.x-western" = "Inter";
        "font.name.monospace.x-western" = "Hack Nerd Font";

        # Optional sizes
        "font.size.variable.x-western" = 16;
        "font.size.monospace.x-western" = 14;
      };
    };
  };
}
