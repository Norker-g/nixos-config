{ config, pkgs, ... }:

{
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 52.52;
    longitude = 13.405;

    temperature = {
      day = 6500;
      night = 3500;
    };

    settings.general = {
      adjustment-method = "wayland";
    };
  };
}
