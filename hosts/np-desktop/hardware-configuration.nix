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

  boot.kernelPackages = pkgs.linuxPackages_6_1;
  boot.zfs.enableUnstable = true;
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = ["amdgpu" "vfio_pci" "vfio" "vfio_iommu_type1" "vfio_virqfd"];
  boot.kernelModules = ["kvm-amd"];
  boot.blacklistedKernelModules = [];
  boot.kernelParams = ["amd_iommu=on" "vfio-pci.ids=10de:1e84,10de:10f8"];
  boot.extraModulePackages = [];
  systemd.services.zfs-mount.enable = false;

  fileSystems."/" = {
    device = "rpool/nixos/empty";
    fsType = "zfs";
    options = ["zfsutil" "X-mount.mkdir"];
  };

  fileSystems."/home" = {
    device = "rpool/nixos/home";
    fsType = "zfs";
    options = ["zfsutil" "X-mount.mkdir"];
  };

  fileSystems."/home/shebang/Games" = {
    device = "rpool/nixos/home/games";
    fsType = "zfs";
    options = ["zfsutil" "X-mount.mkdir"];
  };

  fileSystems."/etc/secrets" = {
    device = "rpool/nixos/secrets";
    fsType = "zfs";
    options = ["zfsutil" "X-mount.mkdir"];
    neededForBoot = true;
  };

  fileSystems."/nix" = {
    device = "rpool/nixos/nix";
    fsType = "zfs";
    options = ["zfsutil" "X-mount.mkdir"];
  };

  fileSystems."/var/lib" = {
    device = "rpool/nixos/var/lib";
    fsType = "zfs";
    options = ["zfsutil" "X-mount.mkdir"];
  };

  fileSystems."/var/log" = {
    device = "rpool/nixos/var/log";
    fsType = "zfs";
    options = ["zfsutil" "X-mount.mkdir"];
  };

  fileSystems."/boot" = {
    device = "bpool/nixos/root";
    fsType = "zfs";
    options = ["zfsutil" "X-mount.mkdir"];
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/959B-2EA1";
    fsType = "vfat";
  };

  zramSwap.enable = true;

  networking.hostId = "324fbcf7";
  # NetworkManager for simpler Wifi configuration
  networking.networkmanager = {
    enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Bluetooth Support
  hardware.bluetooth.enable = true;
  hardware.xone.enable = true;
}
