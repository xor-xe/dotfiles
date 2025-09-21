{config, pkgs, ...}:

let 
  myAliases ={
    ll = "ls -l";
    ls = "lsd";
    cat = "bat";
    ff = "fastfetch";
    ".." = "cd ..";
  };
in
{

  imports = [
    ./ghostty.nix
  ];
  
  home.file.".p10k.zsh".source = ./.p10k.zsh;

  #fast fetch
  home.file.".config/fastfetch/images/red-borjghalo.png".source = ./fastfetch/images/red-borjghalo.png;
  home.file.".config/fastfetch/images/blue-borjghalo.png".source = ./fastfetch/images/blue-borjghalo.png;
  home.file.".config/fastfetch/config.jsonc".source = ./fastfetch/fastfetch.jsonc;

  home.packages = with pkgs; [
    zsh-powerlevel10k
  ];

  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };

  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
    initContent = 
    ''
    # Source Powerlevel10k theme
    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    # Source your configuration (if it exists)
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    fastfetch
    '';
    oh-my-zsh = {
      enable = true;              # enable Oh My Zsh
      plugins = [ 
        "git"
        "z"
        "extract"
       ];   # list of plugins
    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "85919cd1ffa7d2d5412f6d3fe437ebdbeeec4fc5";
          hash = "sha256-KmkXgK1J6iAyb1FtF/gOa0adUnh1pgFsgQOUnNngBaE=";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "5eb677bb0fa9a3e60f0eff031dc13926e093df92";
          hash = "sha256-KRsQEDRsJdF7LGOMTZuqfbW6xdV5S38wlgdcCM98Y/Q=";
        };
      }
      {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "d08cee09cecdc2d95bf501183597411a7632be7c";
          sha256 = "sha256-1ZlYYJrTrstdHWfM73ZpSnGaMwsFCbdRRkI4fMh0R8s=";
        };
      }
      # the following lines are used just to initialize power10k file
      # {
      #   name = "powerlevel10k-config";
      #   src = ./shell;
      #   file = "p10k.zsh";
      # }
      # {
      #   name = "zsh-powerlevel10k";
      #   src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
      #   file = "powerlevel10k.zsh-theme";
      # }
    ];
    autosuggestion.enable = true; # Enables zsh-autosuggestions functionality
    syntaxHighlighting.enable = true; # Enables zsh-syntax-highlighting | if you nebale this calt doesnt work
  };

}