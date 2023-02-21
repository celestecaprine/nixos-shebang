{
  pkgs,
  config,
  ...
}: {
  wayland.windowManager.sway = {
    enable = true;
    config = {
      window = {
        border = 1;
      };
      fonts = {
        names = ["FiraCode Nerd Font Mono"];
        style = "Regular";
        size = 10.0;
      };
      colors = let
        base = "#1e1e2e";
        text = "#cdd6f4";
        blue = "#89b4fa";
        blueBorder = "#526c96";
        teal = "#94e2d5";
        overlay0 = "#6c7086";
        overlay2 = "#9399b2";
        rosewater = "#f5e0dc";
        lavender = "#b4befe";
        lavenderBorder = "#9098cb";
        peach = "#fab387";
      in {
        focused = {
          background = "${blue}";
          text = "${base}";
          indicator = "${rosewater}";
          border = "${blueBorder}";
          childBorder = "${blueBorder}";
        };
        focusedInactive = {
          background = "${base}";
          text = "${text}";
          indicator = "${rosewater}";
          border = "${overlay0}";
          childBorder = "${overlay2}";
        };
        unfocused = {
          background = "${base}";
          text = "${text}";
          indicator = "${rosewater}";
          border = "${overlay0}";
          childBorder = "${overlay2}";
        };
        urgent = {
          background = "${base}";
          text = "${peach}";
          indicator = "${overlay0}";
          border = "${peach}";
          childBorder = "${lavender}";
        };
        placeholder = {
          background = "${base}";
          text = "${text}";
          indicator = "${overlay0}";
          border = "${overlay0}";
          childBorder = "${lavender}";
        };
        background = "${base}";
      };
      focus = {
        mouseWarping = "container";
      };
      workspaceOutputAssign = [
        {
          output = "LG Electronics LG ULTRAGEAR 101NTTQRT897";
          workspace = "1";
        }
        {
          output = "ASUSTek COMPUTER INC ASUS VP228 L4LMTF028577";
          workspace = "11";
        }
      ];
      keybindings = let
        mod = config.wayland.windowManager.sway.config.modifier;
        inherit
          (config.wayland.windowManager.sway.config)
          left
          down
          up
          right
          menu
          terminal
          ;
      in {
        # Swaysome allows me to work with workspaces in a sane manner on multi-monitor systems.

        "${mod}+1" = "exec swaysome focus 1";
        "${mod}+2" = "exec swaysome focus 2";
        "${mod}+3" = "exec swaysome focus 3";
        "${mod}+4" = "exec swaysome focus 4";
        "${mod}+5" = "exec swaysome focus 5";
        "${mod}+6" = "exec swaysome focus 6";
        "${mod}+7" = "exec swaysome focus 7";
        "${mod}+8" = "exec swaysome focus 8";
        "${mod}+9" = "exec swaysome focus 9";
        "${mod}+0" = "exec swaysome focus 0";
        "${mod}+minus" = "scratchpad show";
        "${mod}+Shift+1" = "exec swaysome move 1";
        "${mod}+Shift+2" = "exec swaysome move 2";
        "${mod}+Shift+3" = "exec swaysome move 3";
        "${mod}+Shift+4" = "exec swaysome move 4";
        "${mod}+Shift+5" = "exec swaysome move 5";
        "${mod}+Shift+6" = "exec swaysome move 6";
        "${mod}+Shift+7" = "exec swaysome move 7";
        "${mod}+Shift+8" = "exec swaysome move 8";
        "${mod}+Shift+9" = "exec swaysome move 9";
        "${mod}+Shift+0" = "exec swaysome move 0";
        "${mod}+Shift+minus" = "move scratchpad";

        # Movement binds

        "${mod}+${left}" = "focus left";
        "${mod}+${down}" = "focus down";
        "${mod}+${up}" = "focus up";
        "${mod}+${right}" = "focus right";

        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        "${mod}+Shift+${left}" = "move left";
        "${mod}+Shift+${down}" = "move down";
        "${mod}+Shift+${up}" = "move up";
        "${mod}+Shift+${right}" = "move right";

        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        # Layout Binds

        "${mod}+b" = "splith";
        "${mod}+v" = "splitv";

        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";

        "${mod}+f" = "fullscreen";

        "${mod}+Shift+space" = "floating toggle";

        "${mod}+space" = "focus mode_toggle";

        "${mod}+a" = "focus parent";

        # Launching

        "${mod}+Return" = "exec ${terminal}";
        "${mod}+d" = "exec ${menu}";

        "${mod}+Shift+c" = "kill";
        "${mod}+Shift+r" = "reload";
        "${mod}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";
        "${mod}+Print" = "exec grimshot --notify copy area";
        "${mod}+Shift+Print" = "exec grimshot --notify copy output";
        "${mod}+Control+Print" = "exec grimshot --notify copy active";

        "--locked XF86AudioPlay" = "exec mpc toggle";
        "--locked XF86AudioNext" = "exec mpc next";
        "--locked XF86AudioPrev" = "exec mpc prev";
        "--locked XF86AudioStop" = "exec mpc prev";
        "--locked XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_SINK@ -l 1.0 10%+";
        "--locked XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_SINK@ -l 1.0 10%-";
        "--locked XF86AudioMute" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";
      };
      menu = "bemenu-run";
      bars = [
        {
          fonts = {
            names = ["FiraCode Nerd Font Mono"];
            style = "Regular";
            size = 10.0;
          };
          trayOutput = "DP-2";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs $HOME/.config/i3status-rust/config-default.toml";
          colors = let
            base = "#1e1e2e";
            text = "#cdd6f4";
            blue = "#89b4fa";
            blueBorder = "#526c96";
            teal = "#94e2d5";
            overlay0 = "#6c7086";
            overlay2 = "#9399b2";
            rosewater = "#f5e0dc";
            lavender = "#b4befe";
            lavenderBorder = "#9098cb";
            peach = "#fab387";
            peachBorder = "#966b51";
          in {
            background = "${base}";
            separator = "${overlay0}";
            statusline = "${text}";
            focusedWorkspace = {
              border = "${blueBorder}";
              background = "${blue}";
              text = "${base}";
            };
            urgentWorkspace = {
              border = "${peachBorder}";
              background = "${peach}";
              text = "${text}";
            };
            inactiveWorkspace = {
              border = "${overlay0}";
              background = "${base}";
              text = "${text}";
            };
            activeWorkspace = {
              border = "${overlay0}";
              background = "${base}";
              text = "${text}";
            };
          };
        }
      ];
      modifier = "Mod4";
      terminal = "footclient";
      window = {
        titlebar = true;
      };
      startup = [
        {command = "swww init & swww img $HOME/.config/carouselwallpaper.png";}
        #{command = "waybar";}
        {command = "foot -s";}
        {command = "swaysome init 1";}
        {
          command = "pkill kanshi; exec kanshi";
          always = true;
        }
      ];
    };
    extraConfig = ''
      seat seat0 xcursor_theme Catppuccin-Mocha-Dark-Cursors 32
    '';
  };
  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        blocks = [
          {
            block = "disk_space";
            path = "/";
            alias = "/";
            info_type = "available";
            unit = "GB";
            interval = 60;
            warning = 20.0;
            alert = 10.0;
          }
          {
            block = "memory";
            display_type = "memory";
            format_mem = "{mem_used_percents}";
            format_swap = "{swap_used_percents}";
          }
          {
            block = "cpu";
            interval = 1;
          }
          {block = "sound";}
          {
            block = "time";
            interval = 60;
            format = "%a, %B %d %I:%M %p";
          }
        ];
        theme = "native";
      };
    };
  };
  home.packages = with pkgs; [
    swaysome
    bemenu
    grim
    slurp
    sway-contrib.grimshot
  ];
}
