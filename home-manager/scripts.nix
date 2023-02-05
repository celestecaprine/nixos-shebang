{pkgs, ...}: let
  cava-internal = pkgs.writeShellScriptBin "cava-internal" ''
    cava -p $HOME/.config/waybar/cava-barconfig | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;'
  '';
  tofi-powermenu = pkgs.writeShellScriptBin "tofi-powermenu" ''
    case $(echo -e "lock\nsuspend\nreboot\nshutdown" | tofi --prompt-text "exit:") in
    lock)
    swaylock-shebang;;
    suspend)
    systemctl suspend;;
    reboot)
    systemctl reboot;;
    shutdown)
    systemctl poweroff;;
    esac
  '';
  swaylock-shebang = pkgs.writeShellScriptBin "swaylock-shebang" ''
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

    # Only execute if not already locked
    if ! [ "$(pgrep -x 'swaylock' > /dev/null)" ]
    then
     swaylock \
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
      --image ''${HOME}/.config/carouselwallpaper.png \
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
    fi

  '';
in {
  home.packages = with pkgs; [
    # Waybar Visualizer
    cava-internal
    # Tofi menu that allows for simple power options
    tofi-powermenu
    # Custom Swaylock Config
    swaylock-shebang
  ];
}
