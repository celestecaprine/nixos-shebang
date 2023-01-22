{
  pkgs,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    recommendedEnvironment = true;
    systemdIntegration = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };
  #programs.mako = {
  #  enable = true;
  #  defaultTimeout = 5;
  #  backgroundColor = "#1e1e2e";
  #  textColor = "#cdd6f4";
  #  borderColor = "#89b4fa";
  #  progressColor = "over #313244";
  #  font = "Fira Mono 12";
  #  extraConfig = ''
  #    [urgency=high]
  #    border-color=#fab387
  #  '';
  #};
  home.packages = with pkgs; [
    inputs.hyprwm-contrib.packages.${system}.grimblast
    inputs.hyprpaper.packages.${system}.default
  ];
  xdg.dataFile."/home/shebang/.config/hypr/hyprpaper.conf".source = ../config/hyprpaper.conf;
}
