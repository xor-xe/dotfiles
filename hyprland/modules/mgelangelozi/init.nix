{config, pkgs, ...}:{

  home.packages = with pkgs; [ ffuf seclists ];

  home.file."mgelangelozi/mantra/seclists".source = "${pkgs.seclists}/share/wordlists/seclists";
}