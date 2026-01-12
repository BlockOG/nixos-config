{pkgs, ...}: {
  home.packages = with pkgs; [
    prismlauncher
    openjdk25
  ];
}
