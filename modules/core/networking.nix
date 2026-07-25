{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "core.networking";
  options = delib.singleEnableOption true;

  nixos.ifEnabled =
    { myconfig, ... }:
    {
      networking.hostName = host.name;

      # Enables wireless support via wpa_supplicant.
      # networking.wireless.enable = true;

      # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

      # Enable networking
      networking.networkmanager.enable = true;

      # VPN
      networking.networkmanager.plugins = with pkgs; [
        networkmanager-openvpn
        networkmanager-openconnect
        networkmanager-l2tp
        networkmanager-strongswan
        networkmanager-sstp
        networkmanager-vpnc
      ];

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      # networking.firewall.enable = false;

      # Some programs need SUID wrappers, can be configured further or are
      # started in user sessions.
      # programs.mtr.enable = true;
      # programs.gnupg.agent = {
      #   enable = true;
      #   enableSSHSupport = true;
      # };

      # Enable the OpenSSH daemon.
      services.openssh.enable = true;

      # IP
      networking = {
        useDHCP = false;
        # TODO: Parameterize this
        interfaces.wlp8s0.ipv4.addresses = [
          {
            address = "192.168.0.18";
            prefixLength = 24;
          }
        ];
        defaultGateway = "192.168.0.1";
        nameservers = [ "192.168.0.1" ];
      };
    };
}
