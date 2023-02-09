{
  services = {
    mpd-discord-rpc = {
      enable = true;
      settings = {
        id = 1072561156201402479;
        hosts = ["localhost:6600"];
        format = {
          details = "$title";
          state = "$album by $artist";
          large_image = "small_image";
          small_image = "small_image";
        };
      };
    };
    mpd = {
      enable = true;
      musicDirectory = "/home/shebang/Music";
      dataDir = "/home/shebang/.local/share/mpd";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "MPD Pipewire Output"
        }
      '';
    };
    mpdris2 = {
      enable = true;
      notifications = true;
    };
  };
  programs = {
    ncmpcpp = {
      enable = true;
      settings = {
        header_visibility = "no";
        header_window_color = "default";
        volume_color = "green";
        state_line_color = "black";
        playlist_display_mode = "classic";
        song_list_format = "$5%t $R$6%a";
        now_playing_prefix = "$b";
        now_playing_suffix = "$/b";
        browser_playlist_prefix = "$1»$1 ";
        progressbar_look = "━━━";
        progressbar_color = "black";
        statusbar_visibility = "yes";
        progressbar_elapsed_color = "green";
        statusbar_color = "7";
        song_status_format = "{%t - %a}";
        display_bitrate = "yes";
        song_library_format = "{{%a - %t}|{%f}}{$R%l}";
        empty_tag_color = "black";
        main_window_color = "default";
        centered_cursor = "yes";
        enable_window_title = "yes";
        external_editor = "nvim";
      };
    };
  };
}
