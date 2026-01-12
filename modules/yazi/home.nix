{
  programs.yazi.enable = true;
  programs.yazi = {
    enableNushellIntegration = true;
    shellWrapperName = "y";
  };

  home.file.".config/yazi/theme.toml".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/yazi/refs/heads/main/themes/mocha/catppuccin-mocha-mauve.toml";
    sha256 = "468957ec40ffe053502b2fb58c02389510cfd4130167817bf528c106980a82f3";
  };
  home.file.".config/yazi/Catppuccin-mocha.tmTheme".source = builtins.fetchurl {
    name = "Catppuccin-Mocha.tmTheme";
    url = "https://raw.githubusercontent.com/catppuccin/bat/6810349b28055dce54076712fc05fc68da4b8ec0/themes/Catppuccin%20Mocha.tmTheme";
    sha256 = "0xxashmrrj81y99ia4hvcpmplkzr1rlpgh4idf9inc7bikq6cm9r";
  };
}
