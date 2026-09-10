{ delib, ... }:
delib.host {
  name = "quetzal";

  myconfig = {
    profiles = {
      wsl.enable = true;
      dev.enable = true;
    };

    programs = {
      vscode.enable = false;
      codex.enable = false;
      docker.enable = false;
    };

    # No GUI under WSL (these modules default to enabled).
    desktops.gnome = {
      enable = false;
      ereshkigal-cursors.enable = false;
    };
  };

  home.home.sessionVariables = {
    EDITOR = "nano";
  };
}
