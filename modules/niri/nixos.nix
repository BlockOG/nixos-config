{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.niri.nixosModules.niri];
  nixpkgs.overlays = [inputs.niri.overlays.niri];
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri;
  environment.systemPackages = with pkgs; [
    xwayland-satellite-stable
    xdg-desktop-portal-gnome
    xdg-desktop-portal-termfilechooser
  ];
}
