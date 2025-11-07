{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    roboto
    roboto-serif
  ];
  fonts.fontconfig.defaultFonts.monospace = ["JetBrainsMono NFM"];
  fonts.fontconfig.defaultFonts.serif = ["Roboto Serif"];
  fonts.fontconfig.defaultFonts.sansSerif = ["Roboto"];
}
