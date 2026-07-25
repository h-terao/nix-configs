{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "home";

  nixos.always = {
    home-manager.backupFileExtension = "bak";
  };

  home.always =
    { myconfig, ... }:
    let
      inherit (myconfig.constants) user;
    in
    {
      home = {
        username = user.name;
        # If you don't need Nix-Darwin, or if you're using it exclusively,
        # you can keep the string here instead of the condition.
        homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${user.name}" else "/home/${user.name}";
      };
    };
}
