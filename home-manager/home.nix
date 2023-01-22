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
    "${fetchTarball {
      url = "https://github.com/msteen/nixos-vscode-server/tarball/master";
      sha256 = "1qga1cmpavyw90xap5kfz8i6yz85b0blkkwvl00sbaxqcgib2rvv";
    }}/modules/vscode-server/home.nix"
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    inputs.hyprland.homeManagerModules.default
    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix

    # Desktop - Hyprland
    ./desktop/hyprland.nix

    # Supplementary programs
    ./programs/waybar
    ./programs/foot.nix
    #./programs/rofi.nix
    ./programs/tofi.nix
    ./programs/pass.nix
    ./programs/editors
    ./programs/swaync.nix
    ./programs/newsboat.nix

    # User services
    ./services/mpd.nix
    ./services/gpg-agent.nix
    ./services/swayidle.nix

    ./scripts.nix

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
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "shebang";
    homeDirectory = "/home/shebang";
    file.".config/wallpaper.gif".source = ../wallpaper.gif;
    file.".config/wallpaper.png".source = ../wallpaper.png;
  };

  services.vscode-server.enable = true;
  services.easyeffects.enable = true;
  # services.network-manager-applet.enable = true;

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    # Terminal Apps
    btop
    lf
    tldr
    todo
    nitch
    gh
    cava
    tree

    # Multimedia
    pulsemixer
    pavucontrol
    imv
    yt-dlp
    mpv
    mpvpaper
    mpc-cli
    playerctl
    obs-studio

    inputs.webcord.packages.${pkgs.system}.default

    waypipe
    swaylock-effects
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
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
      name = "Catppuccin-Dark";
      package = pkgs.catppuccin-gtk;
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
