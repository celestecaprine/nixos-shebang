{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./thinkfan.nix
  ];

  networking.hostName = "np-t430";

  services = {
    getty = {
      greetingLine = ''Welcome to NixOS on Shebang's T430! - \l'';
      helpLine = "\nIf lost, please contact celestecaprine@protonmail.com.";
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiIntel
    ];
  };

  services.blueman.enable = true;
}
