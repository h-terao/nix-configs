{
  delib,
  lib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "hardware.networking";
  options = delib.moduleOptions (
    with delib;
    {
      enable = boolOption false;
      useDHCP = boolOption true;
      interface = allowNull (strOption null);
      ipv4.address = allowNull (strOption null);
      ipv4.prefixLength = intOption 24;
      defaultGateway = allowNull (strOption null);
      nameservers = listOfOption str [ ];
    }
  );

  nixos.ifEnabled =
    { cfg, ... }:
    {
      assertions = [
        {
          assertion = (cfg.interface == null) == (cfg.ipv4.address == null);
          message = "hardware.networking.interface and hardware.networking.ipv4.address must be set together";
        }
      ];

      # Enables wireless support via wpa_supplicant.
      # networking.wireless.enable = true;

      # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

      networking = {
        hostName = host.name;
        useDHCP = cfg.useDHCP;
        nameservers = cfg.nameservers;

        networkmanager = {
          enable = true;
          plugins = with pkgs; [
            networkmanager-openvpn
            networkmanager-openconnect
            networkmanager-l2tp
            networkmanager-strongswan
          ];
        };
      }
      // lib.optionalAttrs (cfg.interface != null) {
        interfaces.${cfg.interface}.ipv4.addresses = [
          {
            address = cfg.ipv4.address;
            prefixLength = cfg.ipv4.prefixLength;
          }
        ];
      }
      // lib.optionalAttrs (cfg.defaultGateway != null) {
        defaultGateway = cfg.defaultGateway;
      };
    };
}
