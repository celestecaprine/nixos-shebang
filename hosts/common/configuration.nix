{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Generic Boot Config Options
    ./boot.nix

    # Impermanence - Using in conjunction with ZFS auto-clearing root
    inputs.impermanence.nixosModules.impermanence
  ];

  nixpkgs = {
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Muh... Muh VSCode..........
      allowUnfree = true;
      documentation = {
        nixos.enable = false;
        doc.enable = false;
      };
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
  };

  users = {
    # Prevent users from being fiddled with
    mutableUsers = false;
    users = {
      shebang = {
        isNormalUser = true;
        # /etc/secrets is mounted at boot, this doesn't really work with Impermenance, so I use a ZFS volume.
        passwordFile = "/etc/secrets/shebang.passwd";
        openssh.authorizedKeys.keyFiles = [
          # Desktop System
          ./keys/np-desktop-id_rsa.pub
          ./keys/np-t430-id_rsa.pub
        ];
        # Supplemental Groups
        extraGroups = ["wheel" "video" "audio" "libvirtd" "networkmanager"];
      };
    };
  };

  # security things.
  security.polkit.enable = true;
  # Needed for Pipewire
  security.rtkit.enable = true;
  # Allows Swaylock to function properly
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  services = {
    # GOATed A/V server w/ compatability set up with other modules
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    # SSH Server, with no password auth
    openssh = {
      enable = true;
      allowSFTP = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
    # Included for iPhone tethering
    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };
    # Userspace Virtual FS
    gvfs = {
      enable = true;
    };
    dbus.enable = true;
    flatpak.enable = true;
    # Disk Health Monitoring
    smartd.enable = true;
  };

  # Needed to configure GNOME apps
  programs.dconf.enable = true;
  # It's HIGH NOON for gamers...
  programs.steam.enable = true;

  # Fonts
  fonts.fonts = with pkgs; [
    spleen
    font-awesome
    inter
    fira
    fira-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-extra
    noto-fonts-emoji
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];

  # Used for Screensharing
  xdg.portal = {
    enable = true;
    # XDG Portals Hyprland
    extraPortals = [inputs.xdph.packages.${pkgs.system}.default];
  };

  environment = {
    variables = {
      # Neovim kinda...........
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    sessionVariables = {
      # Forces Electron Apps to use Wayland
      NIXOS_OZONE_WL = "1";
    };
    # replace /bin/sh with dash
    binsh = "${pkgs.dash}/bin/dash";
    # Persistent Directories
    persistence."/nix/persist/system" = {
      directories = [
        "/etc/ssh"
        "/etc/NetworkManager"
      ];
    };
    systemPackages = with pkgs; [
      pinentry-curses
      # Nix Formatter
      inputs.alejandra.defaultPackage.${system}
      # For SMART drives
      smartmontools
      # File Archival
      unzip
      unrar
      jq
      bc
      # Virtual Machine Manager
      virt-manager
      # PostmarketOS stuff
      pmbootstrap
      android-tools

      # for iPhone tethering
      libimobiledevice
      ifuse
    ];
  };

  # Generic Virtual Machine Configuration
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      runAsRoot = false;
      ovmf.enable = true;
    };
    allowedBridges = ["virbr0"];
  };

  # Yee haw
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  # Console visual configuration
  console = {
    earlySetup = true;
    font = "${pkgs.spleen}/share/consolefonts/spleen-16x32.psfu";
    packages = with pkgs; [spleen];
    keyMap = "us";
    colors = [
      "1E1E2E"
      "F38BA8"
      "A6E3A1"
      "F9E2AF"
      "89B4FA"
      "F5C2E7"
      "94E2D5"
      "BAC2DE"
      "585B70"
      "F38BA8"
      "A6E3A1"
      "F9E2AF"
      "89B4FA"
      "F5C2E7"
      "94E2D5"
    ];
  };

  # Manually-defined Hosts
  networking.hosts = {
    "192.168.69.112" = ["survivalmod.celestecaprine.com" "creativemod.celestecaprine.com" "survivalvanilla.celestecaprine.com" "creativevanilla.celestecaprine.com"];
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
