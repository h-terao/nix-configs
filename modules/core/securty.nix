{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "core.security";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    security.polkit.enable = true;

    # TPM2 configurations
    security.tpm2.enable = true;
    security.tpm2.pkcs11.enable = true;
    security.tpm2.tctiEnvironment.enable = true;

    # Enable TPM2 for initrd
    boot.initrd.systemd.enable = true;
    boot.initrd.systemd.tpm2.enable = true;
    # boot.initrd.luks.devices."luks-0b69bffa-7e53-4f67-99bc-1ec35c12e4c1".crypttabExtraOpts = [
    #  "tpm2-device=auto"
    #];
  };
}
