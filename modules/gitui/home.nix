{
  programs.gitui.enable = true;
  programs.gitui.theme = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/gitui/c7661f043cb6773a1fc96c336738c6399de3e617/themes/catppuccin-mocha.ron";
    sha256 = "a2e4a295fb288ee349eadfe88c28f04b68cdc9dbc673b00d13b1851793e4aa3e";
  };
}
