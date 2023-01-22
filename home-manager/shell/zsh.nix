{
  programs.zsh = {
    enable = true;
    history.size = 10000;
    #oh-my-zsh = {
    #  enable = true;
    #  theme = "robbyrussell";
    #};
    #prezto = {
    #  enable = true;
    #  terminal.autoTitle = true;
    #};
    #initExtra = ''
    #  prompt peepcode $
    #'';
    zplug = {
      enable = true;
      plugins = [
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
        { name = "trystan2k/zsh-tab-title";}
      ];
    };
    initExtra = ''
      source ~/.p10k.zsh
    '';
  };
}