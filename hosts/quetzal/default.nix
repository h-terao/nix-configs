{ delib, ... }:
delib.host {
  name = "quetzal";

  myconfig = {
    profiles = {
      wsl.enable = true;
      dev.enable = true;
    };

    programs = {
      docker.enable = false;
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
