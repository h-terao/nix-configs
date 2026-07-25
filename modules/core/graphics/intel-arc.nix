{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "core.graphics.intel-arc";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    # Enable bluetooth
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
