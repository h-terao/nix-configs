{ delib, ... }:
delib.host {
  name = "zapus";

  myconfig = {
    profiles = {
      avf.enable = true;
      dev.enable = true;
    };

    programs = {
      docker.enable = false;
      playwright-cli.enable = false;
    };

    # No GUI under android linux terminal (these modules default to enabled).
    desktops.gnome = {
      enable = false;
    };
  };

  home.home.sessionVariables = {
    EDITOR = "nano";
  };
}
