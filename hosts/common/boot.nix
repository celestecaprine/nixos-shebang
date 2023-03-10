{
  config,
  pkgs,
  lib,
  ...
}: let
  # Define catppuccinGrub package
  catppuccinGrub =
    pkgs.fetchFromGitHub
    {
      owner = "catppuccin";
      repo = "grub";
      rev = "803c5df0e83aba61668777bb96d90ab8f6847106";
      sha256 = "/bSolCta8GCZ4lP0u5NVqYQ9Y3ZooYCNdTwORNvR7M0=";
    };
in {
  # Lots of Bootloader junk
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.generationsDir.copyKernels = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.theme = "${catppuccinGrub}/src/catppuccin-mocha-grub-theme";
  boot.loader.grub.splashImage = "${catppuccinGrub}/src/catppuccin-mocha-grub-theme/background.png";
  boot.loader.grub.version = 2;
  boot.loader.grub.copyKernels = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.zfsSupport = true;
  # Rollback root to an empty state
  boot.initrd.postDeviceCommands = ''
    zpool import -Nf rpool
    zfs rollback -r rpool/nixos/empty@start
    zpool export -a
  '';
  boot.loader.grub.device = "nodev";
}
