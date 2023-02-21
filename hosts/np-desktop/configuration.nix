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

  services.zrepl = {
    enable = true;
    settings = {
      global = {
        logging = [
          {
            type = "syslog";
            format = "human";
            level = "warn";
          }
        ];
      };
      jobs = [
        {
          name = "pools_to_nas";
          type = "push";

          connect = {
            type = "tcp";
            address = "192.168.69.111:8889";
          };
          filesystems = {
            "bpool<" = true;
            "rpool<" = true;
            "rpool/nixos/empty" = false;
            "rpool/nixos/secrets" = false;
            "rpool/nixos/home/games" = false;
          };
          snapshotting = {
            type = "periodic";
            prefix = "zrepl_";
            interval = "24h";
          };
          pruning = {
            keep_sender = [
              {
                type = "not_replicated";
              }
              {
                type = "last_n";
                count = 7;
              }
            ];
            keep_receiver = [
              {
                type = "grid";
                regex = "^zrepl_.*";
                grid = "1x1h(keep=all) | 24x1h | 35x1d | 6x30d";
              }
            ];
          };
        }
      ];
    };
  };

  # Bluetooth
  services.blueman.enable = true;
}
