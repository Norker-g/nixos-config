{
  services.gammastep = {
    enable = true;

    # Schedule and set time range for dusk/dawn
    duskTime = "18:35-20:15";
    dawnTime = "6:00-7:45";

    # Temperature to use at night/day (between 1000 and 25000 Kelvin).
    temperature = {
      day = 6400;
      night = 3700;
    };

    # Tray Icon
    tray = true;

    enableVerboseLogging = true;

    settings = {
      general = {
        adjustment-method = "randr";
      };
      randr = {
        screen = 0;
      };
    };

  };
}
