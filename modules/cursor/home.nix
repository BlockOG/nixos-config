{pkgs, ...}: {
  home.packages = with pkgs; [
    (oreo-cursors-plus.override {cursorsConf = "trans_pink = #F5A9B8";})
  ];

  home.pointerCursor = {
    enable = true;
    name = "oreo_trans_pink_cursors";
    package = pkgs.oreo-cursors-plus;
    size = 32;
    x11.enable = true;
    gtk.enable = true;
    dotIcons.enable = true;
  };

  programs.niri.settings = {
    cursor = {
      theme = "oreo_trans_pink_cursors";
      size = 32;
    };
  };
}
