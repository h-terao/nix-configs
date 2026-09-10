{ delib, ... }:
delib.host {
  name = "quetzal";

  system = "x86_64-linux";

  useHomeManagerModule = true;
  home.home.stateVersion = "26.05";

  # If you're not using NixOS, you can remove this entire block.
  nixos = {
    system.stateVersion = "26.05";
  };
}
