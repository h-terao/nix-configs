{ delib, ... }:
delib.host {
  name = "zapus";

  system = "aarch64-linux";

  useHomeManagerModule = true;
  home.home.stateVersion = "26.05";

  nixos = {
    system.stateVersion = "26.05";
  };
}
