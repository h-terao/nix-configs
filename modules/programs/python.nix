{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.python";
  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      python3
      uv
    ];
  };
}
