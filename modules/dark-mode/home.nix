{pkgs, ...}: {
  home.packages = with pkgs; [
    dconf
  ];

  gtk.enable = true;
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
