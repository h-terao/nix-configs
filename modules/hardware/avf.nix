{ delib, host, ... }:
delib.module {
  name = "hardware.avf";
  options = delib.singleEnableOption false;

  nixos.always.imports = [ ../../packages/avf/module.nix ];

  nixos.ifEnabled =
    { myconfig, ... }:
    {
      networking.hostName = host.name;
      avf = {
        enable = true;
        defaultUser = myconfig.constants.user.name;
      };
    };
}
