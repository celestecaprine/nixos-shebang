{pkgs, ...}: let
  shebang-swaylock = pkgs.writeShellScriptBin "shebang-swaylock" ''
     # Variables
     transparent='00000000'
     teal='94E2D5'
     black='1E1E2E'
     white='cdd6f4'
     rosewater='f5e0dc'
     peach='FAB387'
     yellow='F9E2AF'
     green='A6E3A1'
     red='F38BA8'

    ${pkgs.swaylock-effects}/bin/swaylock \
     --ignore-empty-password \
     --show-failed-attempts \
     --daemonize \
     --indicator \
     --clock \
     --timestr "%I:%M %p" \
     --datestr "%b %d, %G" \
     --indicator-caps-lock \
     --scaling fill \
     --effect-blur 15x5 \
     --effect-vignette 0.2:0.2 \
     --font "Fira Sans" \
     --font-size 45 \
     --indicator-radius 170 \
     --indicator-thickness 15 \
     --image ''${HOME}/.config/wallpaper.png \
     --bs-hl-color "''${rosewater}" \
     --key-hl-color "''${rosewater}" \
     --caps-lock-bs-hl-color "''${white}" \
     --caps-lock-key-hl-color "''${white}" \
     --inside-color "''${black}" \
     --inside-clear-color "''${black}" \
     --inside-caps-lock-color "''${black}" \
     --inside-ver-color "''${black}" \
     --inside-wrong-color "''${black}" \
     --line-color "''${transparent}" \
     --line-clear-color "''${transparent}" \
     --line-caps-lock-color "''${transparent}" \
     --line-ver-color "''${transparent}" \
     --line-wrong-color "''${transparent}" \
     --ring-color "''${peach}" \
     --ring-clear-color "''${yellow}" \
     --ring-caps-lock-color "''${peach}" \
     --ring-ver-color "''${green}" \
     --ring-wrong-color "''${red}" \
     --separator-color "''${transparent}" \
     --text-color "''${white}" \
     --text-clear-color "''${teal}" \
     --text-ver-color "''${teal}" \
     --text-wrong-color "''${teal}" \
     --text-caps-lock-color "''${teal}"
  '';
in {
  services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    events = [
      {
        event = "before-sleep";
        command = "${shebang-swaylock}/bin/shebang-swaylock &";
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "${shebang-swaylock}/bin/shebang-swaylock &";
      }
      {
        timeout = 600;
        command = "${pkgs.wayout}/bin/wayout --off LVDS-1";
        resumeCommand = "${pkgs.wayout}/bin/wayout --on LVDS-1";
      }
    ];
  };
}
