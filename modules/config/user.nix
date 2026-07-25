{ delib, ... }:
delib.module {
  name = "user";

  # If you're not using NixOS, you can remove this entire block.
  nixos.always =
    { myconfig, ... }:
    let
      inherit (myconfig.constants) user;
    in
    {
      users = {
        groups.${user.name} = { };

        users.${user.name} = {
          isNormalUser = true;
          initialPassword = user.name;
          extraGroups = [
            "networkmanager"
            "wheel"
            "tss"
            "docker"
            "video"
            "render"
          ];
        };
      };
    };

  # If you're not using Nix-Darwin, you can remove this entire block.
  darwin.always =
    { myconfig, ... }:
    let
      inherit (myconfig.constants) user;
    in
    {
      users.users.${user.name} = {
        name = user.name;
        home = "/Users/${user.name}";
      };
    };
}
