{ delib, ... }:
delib.host {
  name = "hippo";

  home.home.sessionVariables = {
    EDITOR = "nano";
  };
}
