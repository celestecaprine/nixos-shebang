{
  pkgs,
  inputs,
  host,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    recommendedEnvironment = true;
    systemdIntegration = true;
    #extraConfig = hyprlandConf;
    extraConfig = with host;
      builtins.replaceStrings ["MONITORS"] [
        (
          if host.hostName == "np-t430"
          then ''
            monitor=LVDS-1,1920x1080@60,1920x0,1
          ''
          else if host.hostName == "np-desktop"
          then ''
            monitor=DP-2,2560x1440@144,1920x0,1
            monitor=DP-3,1920x1080@75,0x0,1
          ''
          else false
        )
      ]
      "${builtins.readFile ./hyprland.conf}";
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
