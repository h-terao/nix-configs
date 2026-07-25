{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.google-chrome";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      google-chrome
    ];
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      google-chrome
    ];
  };
}
