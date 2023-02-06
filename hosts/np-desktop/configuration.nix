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

  networking.hostName = "np-desktop";

  # Just in case someone decides to steal a 10 year old laptop covered in My Little Pony stickers. Y'know, just in case.
  services = {
    getty = {
      greetingLine = ''Welcome to NixOS on Shebang's Desktop! - \l'';
      helpLine = "";
    };
  };

  # AMD GPU
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
    ];
  };

  # Bluetooth
  services.blueman.enable = true;
}
