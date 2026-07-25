{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "desktops.cosmic";
  options = delib.singleEnableOption false;
  nixos.ifEnabled = {
    services = {
      # Login manager
      displayManager.cosmic-greeter.enable = true;
      # Desktop environment
      desktopManager.cosmic.enable = true;
      # System76's scheduler for performance optimization
      system76-scheduler.enable = true;
      # Wacom Tablet support
      libinput.enable = true;
    };
    # Clipboard
    environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
    environment.systemPackages = with pkgs; [
      libinput
      libwacom
    ];
  };
}
