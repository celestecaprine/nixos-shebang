{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      kamadorueda.alejandra
      bbenoist.nix
      ms-vscode-remote.remote-ssh
    ];
    userSettings = {
      "editor.fontFamily" = "FiraCode Nerd Font Mono";
      "editor.fontLigatures" = true;
      "workbench.colorTheme" = "Catppuccin Mocha";
    };
  };
}
