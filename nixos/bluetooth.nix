{ config, pkgs, ... }:

{
  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
