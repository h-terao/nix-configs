{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "programs.claude-code";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.claude-code = {
      enable = true;
      package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code;
    };
  };
}
