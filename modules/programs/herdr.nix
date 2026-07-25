{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "programs.herdr";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = [ inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.herdr ];
  };
}
