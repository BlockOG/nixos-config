{lib, ...}: {
  programs.yazi.enable = true;
  programs.yazi = {
    enableNushellIntegration = true;
    shellWrapperName = "y";
  };

  home.file.".config/yazi/theme.toml".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/yazi/043ffae14e7f7fcc136636d5f2c617b5bc2f5e31/themes/mocha/catppuccin-mocha-mauve.toml";
    sha256 = "f61ad1fa6c333720eec9c60db27824fb482712497119f622e9044e177dc75750";
  };
  home.file.".config/yazi/Catppuccin-mocha.tmTheme".source = builtins.fetchurl {
    name = "Catppuccin-Mocha.tmTheme";
    url = "https://raw.githubusercontent.com/catppuccin/bat/6810349b28055dce54076712fc05fc68da4b8ec0/themes/Catppuccin%20Mocha.tmTheme";
    sha256 = "0xxashmrrj81y99ia4hvcpmplkzr1rlpgh4idf9inc7bikq6cm9r";
  };
}
