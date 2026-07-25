{
  delib,
  pkgs,
  ...
}:
let
  package = pkgs.callPackage ../../../packages/ereshkigal-cursors { };
  themeName = "Ereshkigal";
  cursorSize = 28;
in
delib.module {
  name = "desktops.gnome.ereshkigal-cursors";
  # Only one cursor theme can be enabled at a time
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    # Also makes the theme available to GDM and applications running as root
    environment.systemPackages = [ package ];
  };

  home.ifEnabled = {
    home.pointerCursor = {
      inherit package;
      name = themeName;
      size = cursorSize;
      gtk.enable = true;
      x11.enable = true;
    };

    dconf.settings."org/gnome/desktop/interface" = {
      cursor-theme = themeName;
      cursor-size = cursorSize;
    };
  };
}
