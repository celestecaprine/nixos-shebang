{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  boot.initrd.availableKernelModules = ["xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "sdhci_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.kernelParams = ["nohibernate"];
  boot.extraModulePackages = [];
  systemd.services.zfs-mount.enable = false;

  fileSystems."/" = {
    device = "rpool/nixos/empty";
    fsType = "zfs";
    options = ["zfsutil" "noatime" "X-mount.mkdir"];
  };

  fileSystems."/altroot" = {
    device = "rpool/nixos/root";
    fsType = "zfs";
    options = ["zfsutil" "noatime" "X-mount.mkdir"];
    neededForBoot = true;
  };

  fileSystems."/etc/secrets" = {
    device = "rpool/nixos/secrets";
    fsType = "zfs";
    options = ["zfsutil" "noatime" "X-mount.mkdir"];
    neededForBoot = true;
  };

  fileSystems."/var" = {
    device = "rpool/nixos/var";
    fsType = "zfs";
    options = ["zfsutil" "noatime" "X-mount.mkdir"];
  };

  fileSystems."/var/lib" = {
    device = "rpool/nixos/var/lib";
    fsType = "zfs";
    options = ["zfsutil" "noatime" "X-mount.mkdir"];
  };

  fileSystems."/var/log" = {
    device = "rpool/nixos/var/log";
    fsType = "zfs";
    options = ["zfsutil" "noatime" "X-mount.mkdir"];
  };

  fileSystems."/nix" = {
    device = "/altroot/nix";
    fsType = "none";
    options = ["bind" "X-mount.mkdir"];
  };

  fileSystems."/home" = {
    device = "rpool/nixos/home";
    fsType = "zfs";
    options = ["zfsutil" "X-mount.mkdir"];
  };

  fileSystems."/boot" = {
    device = "bpool/nixos/root";
    fsType = "zfs";
    options = ["zfsutil" "X-mount.mkdir"];
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-partuuid/e285f440-5110-44e6-88fb-ab598714714c";
    fsType = "vfat";
  };

  zramSwap.enable = true;

  networking.hostId = "b454d743";
  networking.networkmanager = {
    enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.bluetooth.enable = true;
}
