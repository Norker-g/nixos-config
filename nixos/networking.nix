{ pkgs, ... }:

{
  networking.hostName = "norker-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # NetworkManager is fine here, but the default setup is bare minimum.
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";

    # Realtek laptop Wi-Fi tends to behave better without aggressive power saving.
    wifi.powersave = false;
  };

  # systemd-resolved gives NetworkManager proper DNS integration, DNS caching,
  # and better split-DNS behaviour for VPNs such as Tailscale.
  services.resolved = {
    enable = true;
    settings.Resolve = {
      # The DNS servers handed out by some Wi-Fi networks have been timing
      # out.  A fallback resolver is only used when no link DNS server is
      # configured, so make reliable resolvers the primary route as well.
      # Tailscale's ~ts.net route remains more specific and continues to
      # resolve MagicDNS names through Tailscale.
      DNS = [
        "1.1.1.1"
        "1.0.0.1"
        "9.9.9.9"
        "149.112.112.112"
      ];
      Domains = [ "~." ];
      FallbackDNS = [
        "1.1.1.1"
        "1.0.0.1"
        "9.9.9.9"
        "149.112.112.112"
      ];
    };
  };

  environment.etc."ssl/openssl-clienthello-workaround.cnf".text = ''
    openssl_conf = openssl_init
    config_diagnostics = 1

    [openssl_init]
    providers = provider_sect
    ssl_conf = ssl_configuration

    [provider_sect]
    default = default_sect

    [default_sect]

    [ssl_configuration]
    system_default = tls_system_default

    [tls_system_default]
    # OpenSSL 3.6 advertises a larger default group list. Some networks or
    # middleboxes drop or break that ClientHello, which stalls GitHub access.
    Groups = X25519:P-256:P-384
  '';

  # Make interactive tools and the Nix daemon use the same OpenSSL client
  # policy so Git and `nix flake update` behave consistently.
  environment.variables.OPENSSL_CONF = "/etc/ssl/openssl-clienthello-workaround.cnf";
  systemd.services.nix-daemon.environment.OPENSSL_CONF =
    "/etc/ssl/openssl-clienthello-workaround.cnf";

  # Prefer lower latency under load over raw burst throughput.
  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "fq_codel";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.ipv4.tcp_fastopen" = 3;
  };
}
