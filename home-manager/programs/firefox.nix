{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    profiles.default = {
      extensions = with config.nur.repos.rycee.firefox-addons; [
        browserpass
        privacy-badger
        sponsorblock
        stylus
        tampermonkey
        ublock-origin
      ];
    };
  };
  programs.browserpass = {
    enable = true;
    browsers = ["firefox"];
  };
}
