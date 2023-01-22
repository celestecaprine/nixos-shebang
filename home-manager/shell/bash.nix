{
  programs.bash = {
    enable = true;
    initExtra = ''
      if [ -z "''${DISPLAY}" ] && [ "''${XDG_VTNR}" -eq 1 ]; then
        exec Hyprland
      fi
    '';

    enableCompletion = true;
  };
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[x](bold red)";
      };
      right_format = "$time";
      line_break = {
        disabled = true;
      };
      time = {
        disabled = false;
        style = "bold green";
        format = "[$time]($style)";
      };
    };
  };
}
