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
  # Latest Xanmod Kernel
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.initrd.availableKernelModules = ["xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "sdhci_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm_amd"];
  boot.kernelParams = ["nohibernate"];
  boot.extraModulePackages = [];
  systemd.services.zfs-mount.enable = false;

  # Blank root FS, gets cleared on boot
  fileSystems."/" = {
    device = "rpool/nixos/empty";
    fsType = "zfs";
    options = ["zfsutil" "noatime" "X-mount.mkdir"];
  };

  # Holds top-secret information!
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
    device = "rpool/nixos/nix";
    fsType = "zfs";
    options = ["zfsutil" "noatime" "X-mount.mkdir"];
  };

  # Users
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

  networking.hostId = "585dd486";
  # NetworkManager for simpler Wifi configuration
  networking.networkmanager = {
    enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # Intel Microcode
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Bluetooth Support
  hardware.bluetooth.enable = true;
}
