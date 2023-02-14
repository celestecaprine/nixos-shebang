{host, ...}: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      return {
        color_scheme = 'Catppuccin Mocha',
        font = wezterm.font 'FiraCode Nerd Font Mono',
        harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
        window_background_opacity = 0.9,
        use_fancy_tab_bar = false,
        hide_tab_bar_if_only_one_tab = true,
        cursor_blink_rate = 800
      }
    '';
  };
}
