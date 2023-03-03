{
  home,
  pkgs,
  ...
}: {
  services = {
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gtk2";
      #    enableSshSupport = true;
      #    enableExtraSocket = true;
      extraConfig = ''
        allow-loopback-pinentry
      '';
    };
  };
  programs = {
    gpg = {
      enable = true;
    };
  };
  home.packages = with pkgs; [
    pinentry.qt
  ];
}
