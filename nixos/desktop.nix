{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

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
        # Keep the Q30 on A2DP only. This avoids the low-quality HFP/HSP path
        # and removes a flaky hands-free negotiation path from connection setup.
        "override.bluez5.roles" = [ "a2dp_sink" "a2dp_source" ];

        # Force a conservative codec set for the Q30; without override the
        # default codec list may still be appended by WirePlumber.
        "override.bluez5.codecs" = [ "sbc" ];
        "bluez5.enable-sbc-xq" = false;
        "bluez5.enable-hw-volume" = false;
      };

      "wireplumber.settings" = {
        # Do not restore a previously selected hands-free profile from state.
        "device.restore-profile" = false;
      };
    };
  };
}
