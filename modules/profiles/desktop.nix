{
  delib,
  lib,
  ...
}:
delib.module {
  name = "profiles.desktop";
  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    programs = {
      cups.enable = lib.mkDefault true;
      fcitx5-mozc.enable = lib.mkDefault true;

      brave.enable = lib.mkDefault true;
      google-chrome.enable = lib.mkDefault true;

      vscode.enable = lib.mkDefault true;
      obsidian.enable = lib.mkDefault true;
      slack.enable = lib.mkDefault true;
    };

    hardware = {
      audio.enable = lib.mkDefault true;
      bluetooth.enable = lib.mkDefault true;
      boot.enable = lib.mkDefault true;
      networking.enable = lib.mkDefault true;
    };
  };
}
