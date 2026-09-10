{
  delib,
  ...
}:
delib.module {
  name = "programs.git";
  options = delib.singleEnableOption false;

  home.ifEnabled =
    { myconfig, ... }:
    let
      inherit (myconfig.constants) user;
    in
    {
      programs.git = {
        enable = true;
        settings = {
          user.name = user.fullname;
          user.email = user.email;
          init.defaultBranch = "main";
        };
      };
    };
}
