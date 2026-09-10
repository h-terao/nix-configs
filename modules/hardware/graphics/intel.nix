{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "hardware.graphics.intel";
  options = delib.singleEnableOption true;

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
