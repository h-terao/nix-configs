{
  delib,
  lib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "desktops.gnome";
  options = delib.singleEnableOption true;
  nixos.ifEnabled = {
    services = {
      # Login manager
      displayManager.gdm.enable = true;
      # Desktop environment
      desktopManager.gnome.enable = true;
      # Wacom Tablet support
      libinput.enable = true;

      gnome = {
        games.enable = false;
      };
    };
    environment.systemPackages = with pkgs; [
      gnome-tweaks
      libinput
      libwacom
      wl-clipboard
    ];
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      # Extensions
      gnomeExtensions.kimpanel
      gnomeExtensions.user-themes
      gnomeExtensions.dash-to-dock

      # Themes
      flat-remix-gnome
      flat-remix-gtk
      flat-remix-icon-theme
    ];

    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          kimpanel.extensionUuid
          user-themes.extensionUuid
          dash-to-dock.extensionUuid
        ];
        favorite-apps = [
          "org.gnome.Console.desktop"
          "brave-browser.desktop"
          "google-chrome.desktop"
          "slack.desktop"
          "obsidian.desktop"
          "org.gnome.Nautilus.desktop"
          "org.gnome.Settings.desktop"
        ];
      };

      # Disable automatic suspend
      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-type = "nothing";
        sleep-inactive-battery-type = "nothing";
      };

      # Disable automatic screen blank
      "org/gnome/desktop/session" = {
        idle-delay = lib.gvariant.mkUint32 0;
      };
      "org/gnome/desktop/screensaver" = {
        lock-enabled = false;
      };

      # Window titlebar buttons
      "org/gnome/desktop/wm/preferences" = {
        button-layout = ":minimize,maximize,close";
      };

      # Theme settings
      "org/gnome/desktop/interface" = {
        gtk-theme = "Flat-Remix-GTK-Teal-Light";
        icon-theme = "Flat-Remix-Teal-Light";
        font-name = "Noto Sans CJK JP 11";
        document-font-name = "Noto Sans CJK JP 11";
        monospace-font-name = "PlemolJP Console 11";
      };
      "org/gnome/shell/extensions/user-theme" = {
        name = "Flat-Remix-Light";
      };

      # Dock settings
      "org/gnome/shell/extensions/dash-to-dock" = {
        dock-position = "BOTTOM";
        dock-fixed = false;
        autohide = true;
        intellihide = true;

        extend-height = false;

        multi-monitor = true;

        # Icon
        dash-max-icon-size = 48;
        icon-size-fixed = false;
        transparency-mode = "DYNAMIC";
        running-indicator-style = "DOTS";

        # Items
        show-favorites = true;
        show-running = true;
        show-trash = false;
        show-mounts = false;
        show-show-apps-button = true;

        # 操作
        click-action = "focus-minimize-or-previews";
        scroll-action = "cycle-windows";
      };
    };

    # Create home dirs in English
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = true;
    };

    # xdg-user-dirs-update (and GNOME's locale-change dialog) rewrites this file
    # behind Home Manager's back; without force the next activation tries to back
    # it up and dies on the leftover .bak.
    xdg.configFile."user-dirs.dirs".force = true;
  };
}
