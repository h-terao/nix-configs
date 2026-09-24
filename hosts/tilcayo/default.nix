{ delib, ... }:
delib.host {
  name = "tilcayo";

  myconfig = {
    profiles = {
      desktop.enable = true;
      dev.enable = true;
    };

    # Let NetworkManager manage DHCP.
    hardware.networking.useDHCP = false;
  };

  home.home.sessionVariables = {
    EDITOR = "nano";
  };
}
