{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.cups";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    # Enable CUPS to print documents.
    services.printing.enable = false;
  };
}
