{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "hardware.graphics.intel";
  options = delib.singleEnableOption false;

  # xpu-smi is only useful with the Intel graphics stack below, so it follows
  # this module instead of being enabled per host. Intel GPUs without sysman
  # support (iGPUs) can opt out by setting this to false.
  myconfig.ifEnabled.hardware.graphics.intel.xpumanager.enable = lib.mkDefault true;

  nixos.ifEnabled = {
    # Enable Intel graphics
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-compute-runtime
      ];
    };

    environment.systemPackages = with pkgs; [
      intel-gpu-tools
    ];
  };
}
