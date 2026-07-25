{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "core.printing";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    # Enable CUPS to print documents.
    services.printing.enable = false;
  };
}
