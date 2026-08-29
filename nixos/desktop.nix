{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Quickshell's PamContext uses this service for the secure nordlock screen.
  security.pam.services.quickshell-lock = { };

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      clock = "%c";
    };
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    wireplumber.enable = true;

    wireplumber.extraConfig."10-bluez" = {
      "monitor.bluez.properties" = {
        # Expose only headset profiles (HSP/HFP), never A2DP. The Q30 loses
        # its BR/EDR link while using A2DP. *_hs / *_hf are this computer's
        # Headset / Hands-Free endpoints.
        "override.bluez5.roles" = [ "hsp_hs" "hfp_hf" ];
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = false;
      };

      "wireplumber.settings" = {
        # Do not restore a previously selected hands-free profile from state.
        "device.restore-profile" = false;
        "bluetooth.autoswitch-to-headset-profile" = true;
      };
    };
  };
}
