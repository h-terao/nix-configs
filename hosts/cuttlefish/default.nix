{ delib, ... }:
delib.host {
  name = "cuttlefish";

  myconfig = {
    profiles = {
      wsl.enable = true;
      dev.enable = true;
    };

    # No GUI under WSL (these modules default to enabled).
    desktops.gnome = {
      enable = false;
    };
  };

  home.home.sessionVariables = {
    EDITOR = "nano";
  };
}
