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
  boot.kernelModules = ["kvm-intel"];
  boot.kernelParams = ["nohibernate"];
  boot.extraModulePackages = [];
  systemd.services.zfs-mount.enable = false;

  # Blank root FS, gets cleared on boot
  fileSystems."/" = {
    device = "rpool/nixos/empty";
    fsType = "zfs";
    options = ["zfsutil" "noatime" "X-mount.mkdir"];
  };

  # Alternate root FS, holds Nix data
  fileSystems."/altroot" = {
    device = "rpool/nixos/root";
    fsType = "zfs";
    options = ["zfsutil" "noatime" "X-mount.mkdir"];
    neededForBoot = true;
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

  # Nix data from altroot
  fileSystems."/nix" = {
    device = "/altroot/nix";
    fsType = "none";
    options = ["bind" "X-mount.mkdir"];
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

  networking.hostId = "b454d743";
  # NetworkManager for simpler Wifi configuration
  networking.networkmanager = {
    enable = true;
  };

  services = {
    # TLP, assists with laptop power saving
    tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
      };
    };
  };

  # Set CPU Governor
  powerManagement.cpuFreqGovernor = "schedutil";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # Intel Microcode
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Bluetooth Support
  hardware.bluetooth.enable = true;
}
