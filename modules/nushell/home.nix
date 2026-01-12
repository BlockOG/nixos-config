{
  programs.nushell.enable = true;
  programs.nushell = {
    extraConfig =
      "source "
      + (builtins.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/nushell/10a429db05e74787b12766652dc2f5478da43b6f/themes/catppuccin_mocha.nu";
        sha256 = "d639441cd3b4afe1d05157da64c0564c160ce843182dfe9043f76d56ef2c9cdf";
      });
    shellAliases = {
      drag = "ripdrag -nAx";
    };
  };
}
