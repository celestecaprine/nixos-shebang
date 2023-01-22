# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ../../secrets/passwords.nix
    ./boot.nix
    inputs.impermanence.nixosModules.impermanence
  ];

  nixpkgs = {
    # You can add overlays here
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
      # Disable if you don't want unfree packages
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
    #defaultUserShell = pkgs.zsh;
    mutableUsers = true;
    users = {
      shebang = {
        isNormalUser = true;
        initialPassword = "changeme";
        openssh.authorizedKeys.keyFiles = [
          ./keys/np-desktop-id_rsa.pub
        ];
        extraGroups = ["wheel" "video" "audio" "libvirtd"];
      };
    };
  };

  # security things.
  security.polkit.enable = true;
  security.rtkit.enable = true;
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services = {
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
    openssh = {
      enable = true;
      allowSFTP = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
    };
    gvfs = {
      enable = true;
    };
    tlp = {
      enable = true;
    };
    dbus.enable = true;
    flatpak.enable = true;
    smartd.enable = true;
  };

  programs.dconf.enable = true;
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

  xdg.portal = {
    enable = true;
    #wlr.enable = true;
    extraPortals = [inputs.xdph.packages.${pkgs.system}.default];
  };

  # replace /bin/sh with dash
  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    binsh = "${pkgs.dash}/bin/dash";
    persistence."/nix/persist/system" = {
      directories = [
        "/etc/ssh"
        "/etc/NetworkManager"
      ];
      files = [
        "/etc/passwd"
      ];
    };
    systemPackages = with pkgs; [
      pinentry-curses
      inputs.alejandra.defaultPackage.${system}
      smartmontools
      unzip
      unrar
      jq
      bc
      virt-manager
    ];
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      runAsRoot = false;
      ovmf.enable = true;
    };
    allowedBridges = ["virbr0"];
  };

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
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

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
