{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Desktop Hardware Configuration
    ./hardware-configuration.nix
  ];

  boot.loader.grub.useOSProber = true;

  networking.hostName = "np-desktop";

  # Just in case someone decides to steal a 10 year old laptop covered in My Little Pony stickers. Y'know, just in case.
  services = {
    getty = {
      greetingLine = ''Welcome to NixOS on Shebang's Desktop! - \l'';
      helpLine = "";
    };
  };

  virtualisation.libvirtd.qemu = {
    verbatimConfig = ''
      cgroup_device_acl = [
      "/dev/null", "/dev/full", "/dev/zero",
      "/dev/random", "/dev/urandom",
      "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
      "/dev/rtc","/dev/hpet",
      "/dev/input/by-id/usb-SONiX_USB_DEVICE-event-kbd",
      "/dev/input/by-id/usb-Logitech_USB_Receiver-if02-event-mouse"
      ]

      clear_emulator_capabilities = 0
    '';
    swtpm.enable = true;
  };

  # AMD GPU

  # services.xserver.videoDrivers = [
  #   "amdgpu"
  #   "amdgpu-pro"
  # ];

  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
    enable = true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}"
    "f /dev/shm/looking-glass 0660 shebang kvm -"
  ];

  # Bluetooth
  services.blueman.enable = true;
}
