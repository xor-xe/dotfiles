{config, pkgs, ...}:

let 
  myAliases ={
    ll = "ls -l";
    ".." = "cd ..";
  };
in
{
  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };

  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
    initContent = 
    ''
    fastfetch
    '';
  };

  programs.zsh.oh-my-zsh = {
      enable = true;              # enable Oh My Zsh
      theme = "robbyrussell";         # or "robbyrussell", etc.
      plugins = [ "git" "z" ];   # list of plugins
    };
}