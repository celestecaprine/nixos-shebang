{
  pkgs,
  config,
  ...
}: {
  # services.kanshi = {
  #   enable = true;
  #   profiles = {
  #     default = {
  #       outputs = [
  #         {
  #           criteria = "LG Electronics LG ULTRAGEAR 101NTTQRT897";
  #           mode = "2560x1440@144Hz";
  #           position = "1920,0";
  #         }
  #         {
  #           criteria = "ASUSTek COMPUTER INC ASUS VP228 L4LMTF028577";
  #           mode = "1920x1080@75Hz";
  #           position = "0,0";
  #         }
  #       ];
  #     };
  #   };
  # };
  home.packages = with pkgs; [kanshi];
  home.file.".config/kanshi/config".text = ''
    profile default {
      output "LG Electronics LG ULTRAGEAR 101NTTQRT897" mode 2560x1440@144Hz position 1920,0
      output "ASUSTek COMPUTER INC ASUS VP228 L4LMTF028577" mode 1920x1080@75Hz position 0,0
    }
  '';
}
#monitor=DP-2,2560x1440@144,1920x0,1
#monitor=DP-3,1920x1080@75,0x0,1

