{pkgs, ...}:

{
  home.packages = with pkgs; [ tofi j4-dmenu-desktop];
  home.file = { 
    ".config/tofi/config".text = ''
      width = 100%
      height = 100%
      border-width = 0
      outline-width = 0
      padding-left = 35%
      padding-top = 35%
      result-spacing = 25
      num-results = 5
      font = Inter V
      text-color = #cdd6f4
      background-color = #1e1e2e80
      selection-color = #89b4fa
    '';
  };
}