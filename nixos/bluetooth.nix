{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
        # Important for Soundcore Q30 disconnect bug
        ControllerMode = "bredr";

        # Avoid manually restricting Enable for now
        # Enable = "Source,Sink,Media,Socket";

        Experimental = true;
        FastConnectable = true;
      };

      Policy = {
        AutoEnable = true;
      };
    };
  };
}
