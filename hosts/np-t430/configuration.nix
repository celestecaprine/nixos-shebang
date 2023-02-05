{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # T430 Hardware Configuration
    ./hardware-configuration.nix
    # T430 Fan Config
    ./thinkfan.nix
  ];

  networking.hostName = "np-t430";

  # Just in case someone decides to steal a 10 year old laptop covered in My Little Pony stickers. Y'know, just in case.
  services = {
    getty = {
      greetingLine = ''Welcome to NixOS on Shebang's T430! - \l'';
      helpLine = "\nIf lost, please contact celestecaprine@protonmail.com.";
    };
  };

  # Laptop-Specific Packages
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  # Intel iGPU
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiIntel
    ];
  };

  # Bluetooth
  services.blueman.enable = true;
}
