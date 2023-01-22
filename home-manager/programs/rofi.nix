{pkgs, ...}:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "run,drun";
      icon-theme = "Papirus-Dark";
      show-icons = true;
      terminal = "footclient";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 﩯  Window";
      display-Network = " 󰤨  Network";
      sidebar-mode = true;
    };
    theme = "catppuccin-mocha";
  };
  home.file.".config/rofi/catppuccin-mocha.rasi".source = ../config/rofi/catppuccin-mocha.rasi;
}