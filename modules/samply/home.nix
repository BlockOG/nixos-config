{pkgs, ...}: {
  home.packages = with pkgs; [
    samply
  ];
}
