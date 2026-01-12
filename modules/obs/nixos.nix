{pkgs, ...}: {
  programs.obs-studio.enable = true;
  programs.obs-studio.enableVirtualCamera = true;
  programs.obs-studio.plugins = with pkgs; [obs-studio-plugins.obs-vkcapture];
}
