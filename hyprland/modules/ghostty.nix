{...}:{
  programs.ghostty.enable = true;
  programs.ghostty.settings = {
      theme = "nord-wave";
      shell-integration = "zsh";
      font-size = 10;
      keybind = [
        "ctrl+h=goto_split:left"
        "ctrl+l=goto_split:right"
      ];
  };
}