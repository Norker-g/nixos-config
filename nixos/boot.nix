{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Repeated freezes line up with amdgpu DMCUB and eDP-1 commit timeouts.
  # Disable the panel power-saving features most commonly involved in those
  # hangs on AMD laptop displays.
  boot.kernelParams = [
    "amdgpu.dcdebugmask=0xc10"
  ];
}
