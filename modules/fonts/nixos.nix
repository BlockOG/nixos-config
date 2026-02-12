{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    roboto
    roboto-serif
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];
  fonts.fontconfig.defaultFonts.monospace = ["JetBrainsMono NFM"];
  fonts.fontconfig.defaultFonts.serif = ["Roboto Serif" "Noto CJK Serif"];
  fonts.fontconfig.defaultFonts.sansSerif = ["Roboto" "Noto CJK Sans"];
}
