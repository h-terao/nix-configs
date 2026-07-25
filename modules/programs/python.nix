{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.python";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      python3
      uv
    ];
  };
}
