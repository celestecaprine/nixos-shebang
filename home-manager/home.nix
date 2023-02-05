# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # VSCode server
    "${fetchTarball {
      url = "https://github.com/msteen/nixos-vscode-server/tarball/master";
      sha256 = "1qga1cmpavyw90xap5kfz8i6yz85b0blkkwvl00sbaxqcgib2rvv";
    }}/modules/vscode-server/home.nix"
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    inputs.hyprland.homeManagerModules.default
    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix

    # Desktop Configuration

    # Desktop - Hyprland
    ./desktop/hyprland.nix

    # Program-Specific Configurations

    # Waybar - Status Bar
    ./programs/waybar
    # Foot - Terminal
    ./programs/foot.nix
    # Tofi - Launcher
    ./programs/tofi.nix
    # Pass - Password Manager
    ./programs/pass.nix
    # Editors - Vim and VSCodium
    ./programs/editors
    # SwayNC, Notification Daemon
    ./programs/swaync.nix
    # Newsboat, RSS Reader
    ./programs/newsboat.nix

    # Services

    # Music Player Daemon
    ./services/mpd.nix
    # GPG Agent - Key Authentication
    ./services/gpg-agent.nix
    # SwayIdle - Idle Daemon for Screen locking
    ./services/swayidle.nix

    # Personal Scripts
    ./scripts.nix

    # Shell config - Bash
    ./shell/bash.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      (self: super: {
        discord = super.discord.override {withOpenASAR = true;};
      })
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
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "shebang";
    homeDirectory = "/home/shebang";
    # Wallpapers by AstroEden (@astroeden) and Stereo (@strflr)
    file.".config/wallpaper.gif".source = ../wallpaper.gif;
    file.".config/wallpaper.png".source = ../wallpaper.png;
    file.".config/carouselwallpaper.png".source = ../carouselwallpaper.png;
  };

  # VSCode Server
  services.vscode-server.enable = true;
  # EasyEffects for Equalization
  services.easyeffects.enable = true;

  home.packages = with pkgs; [
    # Terminal Apps
    btop
    cava
    gh
    lf
    nitch
    tldr
    todo
    tree
    yt-dlp

    # Multimedia
    imv
    mpv
    pavucontrol
    playerctl
    pulsemixer

    # MPD Programs, also see: ./services/mpd.nix
    mpc-cli
    obs-studio

    # Webcord
    inputs.webcord.packages.${pkgs.system}.default

    # Wayland-specific Programs
    waypipe
    swaylock-effects

    # Minceraft
    prismlauncher
    packwiz
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  # Personal git configuration
  programs.git = {
    extraConfig.credential."https://github.com".helper = lib.mkForce "!${pkgs.gh}/bin/gh auth git-credential";
    enable = true;
    userEmail = "celestecaprine@protonmail.com";
    userName = "Shebang";
    signing = {
      key = "9FFF 288F 4DCC 5B50 FCE8  0838 66B2 5F17 53CA 72C3";
      signByDefault = true;
    };
  };

  # based web browser
  programs.firefox = {
    enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Theming
  home.pointerCursor = {
    gtk.enable = true;
    name = "Catppuccin-Mocha-Dark-Cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 32;
    x11 = {
      enable = true;
      defaultCursor = "Catppuccin-Mocha-Dark-Cursors";
    };
  };
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["blue"];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "Inter V";
    };
    gtk3.extraConfig = {gtk-decoration-layout = "";};
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
