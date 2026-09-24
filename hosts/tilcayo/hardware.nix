{
  delib,
  config,
  lib,
  modulesPath,
  ...
}:
delib.host {
  name = "tilcayo";

  system = "x86_64-linux";

  useHomeManagerModule = true;
  home.home.stateVersion = "26.05";

  nixos = {
    # Keep the release version used for the initial installation.
    system.stateVersion = "26.05";

    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    boot.initrd.availableKernelModules = [
      "xhci_pci"
      "nvme"
      "usb_storage"
      "sd_mod"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/3268e1da-da9d-44dd-adec-2073cc01dd93";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/E03D-806B";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
