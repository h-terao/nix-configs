{
  delib,
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
delib.host {
  name = "hippo";

  system = "x86_64-linux";

  useHomeManagerModule = true;
  home.home.stateVersion = "25.11";

  # If you're not using NixOS, you can remove this entire block.
  nixos = {
    system.stateVersion = "25.11";

    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "thunderbolt"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/mapper/luks-71af17f5-434c-4b37-9dd4-3afcfe180655";
      fsType = "ext4";
    };

    boot.initrd.luks.devices."luks-71af17f5-434c-4b37-9dd4-3afcfe180655".device =
      "/dev/disk/by-uuid/71af17f5-434c-4b37-9dd4-3afcfe180655";

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/E63C-5871";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
