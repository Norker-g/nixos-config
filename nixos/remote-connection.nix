{ config, pkgs, ... }:

{
  services.tailscale.enable = true;

  systemd.services.ttyd = {
    description = "Browser terminal via ttyd";
    after = [
      "network.target"
      "tailscaled.service"
    ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      User = "norker";
      WorkingDirectory = "/home/norker";
      Restart = "always";

      ExecStart = ''
        ${pkgs.ttyd}/bin/ttyd \
          -i 127.0.0.1 \
          -p 7681 \
          -W \
          -P 5 \
          -m 0 \
          -t rendererType=canvas \
          -t disableResizeOverlay=true \
          ${pkgs.zsh}/bin/zsh -l \
      '';
    };
  };

  services.caddy = {
    enable = true;

    virtualHosts.":8080".extraConfig = ''
      basic_auth {
        norker $2a$14$HlUQ1m2ms0GMqPaiiSw/p.mXnyT0ubu5RMAJ2f1ymLPRS3dOFcOA.
       }

      reverse_proxy 127.0.0.1:7681
    '';
  };

  networking.firewall.allowedTCPPorts = [ 8080 ];
}
