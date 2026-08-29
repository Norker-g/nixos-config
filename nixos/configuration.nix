# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Split the config into multiple files
    ./apps.nix
    ./bluetooth.nix
    ./boot.nix
    ./desktop.nix
    ./font.nix
    ./linking.nix
    ./locale.nix
    ./maintenance.nix
    ./networking.nix
    ./packages.nix
    ./printer.nix
    ./users.nix
    ./remote-connection.nix
  ];
  environment.variables = {
    VISUAL = "nvim";
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim -u ~/.config/nvim/init.lua";
  };

  programs.kdeconnect.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false; # usually false for laptops unless you know you need open drivers
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;

      # For your AMD iGPU + NVIDIA dGPU setup:
      amdgpuBusId = "PCI:65:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # enable android emulator
  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };

  services.supergfxd.enable = true;

  hardware.keyboard.zsa.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Emable the "nix" commmand:
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
