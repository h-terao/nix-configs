{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "programs.chatgpt";
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [ inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.chatgpt ];
  };
}
