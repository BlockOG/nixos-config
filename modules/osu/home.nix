{pkgs, ...}: {
  home.packages = with pkgs; [
    (osu-lazer-bin.override {nativeWayland = true;})
  ];
}
