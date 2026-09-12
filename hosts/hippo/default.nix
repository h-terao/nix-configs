{ delib, ... }:
delib.host {
  name = "hippo";

  myconfig = {
    profiles = {
      desktop.enable = true;
      dev.enable = true;
    };

    hardware = {
      graphics.intel.enable = true;
      tpm = {
        enable = true;
        luksDeviceName = "luks-e928bd5d-c0e5-4138-bb18-1e8d70b143c2";
      };

      networking = {
        useDHCP = false;
        interface = "wlp8s0";
        ipv4 = {
          address = "192.168.0.18";
          prefixLength = 24;
        };
        defaultGateway = "192.168.0.1";
        nameservers = [ "192.168.0.1" ];
      };
    };

    programs.lmstudio.enable = true;
  };

  home.home.sessionVariables = {
    EDITOR = "nano";
  };
}
