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
        # Do not override bluez5.roles here.
        # Let WirePlumber expose its default roles.

        "bluez5.codecs" = [ "sbc" ];
        "bluez5.enable-sbc-xq" = false;
        "bluez5.enable-msbc" = false;
        "bluez5.enable-hw-volume" = false;
      };
    };
  };
}
