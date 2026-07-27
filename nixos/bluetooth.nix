{ pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
        # Important for Soundcore Q30 disconnect bug
        ControllerMode = "bredr";

        # Keep bluetoothd on the stable path; Q30 does not need experimental
        # features and FastConnectable has been reported to worsen quick-drop
        # headset failures on newer BlueZ stacks.
        Experimental = false;
        FastConnectable = false;
      };

      Policy = {
        AutoEnable = true;
      };
    };
  };

  # Work around the Q30 "connects, waits a few seconds, disconnects" regression
  # seen on newer BlueZ stacks by restarting bluetoothd once after boot.
  systemd.services.bluetooth-restart-after-boot = {
    description = "Restart bluetooth once after boot for Q30 stability";
    wantedBy = [ "multi-user.target" ];
    after = [ "bluetooth.service" ];
    wants = [ "bluetooth.service" ];
    serviceConfig = {
      Type = "oneshot";
    };
    script = ''
      ${pkgs.coreutils}/bin/sleep 3
      ${pkgs.systemd}/bin/systemctl restart bluetooth.service
    '';
  };
}
