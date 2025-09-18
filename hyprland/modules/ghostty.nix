{...}:{
  programs.ghostty.enable = true;
  programs.ghostty.settings = {
      theme = "nord-wave";
      shell-integration = "zsh";
      font-size = 10;
      window-padding-x = 10;       # gives left & right padding of 10 points
      window-padding-y = 8;        # top & bottom padding of 8 points
      window-padding-balance = true;
      keybind = [
        "ctrl+h=goto_split:left"
        "ctrl+l=goto_split:right"
      ];
  };
}