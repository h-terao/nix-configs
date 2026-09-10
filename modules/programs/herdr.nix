{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "programs.herdr";
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [ inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.herdr ];
  };
}
