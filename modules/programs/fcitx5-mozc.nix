{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.fcitx5-mozc";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-mozc
          fcitx5-gtk
          kdePackages.fcitx5-qt
        ];
      };
    };

    environment.sessionVariables = {
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
    };
  };

  home.ifEnabled = {
    xdg.configFile."fcitx5/config".text = ''
      [Hotkey]
      EnumerateWithTriggerKeys=True
      EnumerateSkipFirst=False

      [Hotkey/TriggerKeys]
      0=Control+space

      [Behavior]
      ActiveByDefault=False
      ShareInputState=No
    '';

    xdg.configFile."fcitx5/profile".text = ''
      [Groups/0]
      Name=Default
      Default Layout=us
      DefaultIM=mozc

      [Groups/0/Items/0]
      Name=keyboard-us
      Layout=

      [Groups/0/Items/1]
      Name=mozc
      Layout=

      [GroupOrder]
      0=Default
    '';

    xdg.configFile."autostart/org.fcitx.Fcitx5.desktop".text = ''
      [Desktop Entry]
      Hidden=true
    '';

    systemd.user.services.fcitx5 = {
      Unit = {
        Description = "Fcitx5 IME";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "/run/current-system/sw/bin/fcitx5 -r";
        Restart = "on-failure";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
