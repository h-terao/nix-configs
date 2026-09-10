{
  delib,
  inputs,
  host,
  ...
}:
delib.module {
  name = "hardware.wsl";
  options = delib.singleEnableOption false;

  # NixOS-WSL gates its own config on `wsl.enable`, so importing it is always safe.
  nixos.always.imports = [ inputs.nixos-wsl.nixosModules.default ];

  nixos.ifEnabled =
    { myconfig, ... }:
    let
      inherit (myconfig.constants) user;
    in
    {
      wsl = {
        enable = true;
        defaultUser = user.name;
        # This is what actually sets the hostname of the WSL instance.
        wslConf.network.hostname = host.name;
      };

      # Keep the NixOS-side hostname in sync (system generation name, /etc/hostname).
      networking.hostName = host.name;

      # Keep systemd user units running after the last shell exits.
      users.users.${user.name}.linger = true;
    };
}
