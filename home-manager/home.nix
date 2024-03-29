# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  host,
  ...
}: let
  catppuccinQt =
    pkgs.fetchFromGitHub
    {
      owner = "catppuccin";
      repo = "Kvantum";
      rev = "04be2ad3d28156cfb62478256f33b58ee27884e9";
      sha256 = "apOPiVwePXbdKM1/0HAfHzIqAZxvfgL5KHzhoIMXLqI=";
    };
in {
  # You can import other home-manager modules here
  imports = [
    # VSCode server
    "${fetchTarball {
      url = "https://github.com/msteen/nixos-vscode-server/tarball/57f1716bc625d2892579294cc207956679e3d94c";
      sha256 = "0ahgyd2swkapimvf70ah2y55wpn2hdh1wymfh6492xrkv5x91sqz";
    }}/modules/vscode-server/home.nix"
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    # inputs.hyprland.homeManagerModules.default
    inputs.nur.nixosModules.nur
    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix

    # Desktop Configuration

    # Desktop - Hyprland
    #./desktop/hyprland

    # Desktop - Sway
    ./desktop/sway

    # Monitor setup for Sway
    ./programs/kanshi.nix

    # Program-Specific Configurations

    # Waybar - Status Bar
    ./programs/waybar
    # Foot - Terminal
    ./programs/foot.nix
    # WezTerm - Terminal
    # ./programs/wezterm.nix
    # lf-sixel - Terminal File Manager
    ./programs/lf.nix
    # Tofi - Launcher
    ./programs/tofi.nix
    # Pass - Password Manager
    ./programs/pass.nix
    # Editors - Vim and VSCodium
    ./programs/editors
    # SwayNC - Notification Daemon
    # ./programs/swaync.nix
    # Mako - Notification Daemon
    ./programs/mako.nix
    # Newsboat - RSS Reader
    ./programs/newsboat.nix
    # Firefox - Web Browser
    ./programs/firefox.nix

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

      (import ../pkgs)
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
    file.".config/Kvantum/Catppuccin-Mocha-Blue/Catppuccin-Mocha-Blue.kvconfig".source = "${catppuccinQt}/src/Catppuccin-Mocha-Blue/Catppuccin-Mocha-Blue.kvconfig";
    file.".config/Kvantum/Catppuccin-Mocha-Blue/Catppuccin-Mocha-Blue.svg".source = "${catppuccinQt}/src/Catppuccin-Mocha-Blue/Catppuccin-Mocha-Blue.svg";
    file.".config/gtk-4.0/assets".source = "${pkgs.catppuccin-gtk}/share/themes/Catppuccin-Mocha-Standard-Blue-Dark/gtk-4.0/assets";
    file.".config/gtk-4.0/gtk.css".source = "${pkgs.catppuccin-gtk}/share/themes/Catppuccin-Mocha-Standard-Blue-Dark/gtk-4.0/gtk.css";
    file.".config/gtk-4.0/gtk-dark.css".source = "${pkgs.catppuccin-gtk}/share/themes/Catppuccin-Mocha-Standard-Blue-Dark/gtk-4.0/gtk-dark.css";
    sessionVariables = {
      QT_STYLE_OVERRIDE = "kvantum";
    };
  };
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "image/jpeg" = "imv.desktop";
      "image/png" = "imv.desktop";
      "image/svg+xml" = "imv.desktop";
      "image/avif" = "imv.desktop";
      "image/gif" = "imv.desktop";
      "application/pdf" = "zathura.desktop";
      "text/plain" = "nvim.desktop";
      "text/css" = "nvim.desktop";
      "text/csv" = "nvim.desktop";
      "text/html" = "firefox.desktop";
      "text/xml" = "nvim.desktop";
    };
    defaultApplications = {
      "image/jpeg" = "imv.desktop";
      "image/png" = "imv.desktop";
      "image/svg+xml" = "imv.desktop";
      "image/avif" = "imv.desktop";
      "image/gif" = "imv.desktop";
      "application/pdf" = "zathura.desktop";
      "text/plain" = "nvim.desktop";
      "text/css" = "nvim.desktop";
      "text/csv" = "nvim.desktop";
      "text/html" = "firefox.desktop";
      "text/xml" = "nvim.desktop";
    };
  };
  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Catppuccin-Mocha-Blue
  '';

  # VSCode Server
  services.vscode-server.enable = true;
  # EasyEffects for Equalization
  services.easyeffects.enable = true;

  home.packages = with pkgs; [
    imagemagick
    poppler
    gnome-epub-thumbnailer
    #wkhtmltopdf
    bat
    unzip
    p7zip
    unrar
    catdoc
    glow
    libcdio
    transmission
    chafa
    blockbench-electron
    btop
    cava
    lf-sixel
    exiftool
    ffmpeg
    ffmpegthumbnailer
    fzf
    gh
    gimp
    imv
    inkscape
    libsForQt5.qtstyleplugin-kvantum
    mpc-cli
    mpv
    nitch
    nodejs
    obs-studio
    packwiz
    pavucontrol
    pcmanfm
    playerctl
    prismlauncher
    pulsemixer
    rnix-lsp
    sshfs
    sumneko-lua-language-server
    swaylock-effects
    tetrio-desktop
    tldr
    todo
    tree
    waypipe
    webcord
    wl-clipboard
    yt-dlp
    zathura
    (
      if host.hostName == "np-desktop"
      then blender-hip
      else blender
    )
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
    gtk4.extraConfig = {gtk-decoration-layout = "";};
  };
  qt = {
    enable = true;
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    BEMENU_OPTS = ''-b -i -H 25 --fb "#1e1e2e" --ff "#94e2d5" --nb "#1e1e2e" --nf "#f5e0dc" --tb "#1e1e2e" --hb "#1e1e2e" --tf "#cba6f7" --hf "#89b4fa" --nf "#f5e0dc" --af "#f5e0dc" --ab "#1e1e2e"'';
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
