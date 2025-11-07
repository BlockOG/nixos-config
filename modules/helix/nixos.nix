{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.helix];
  environment.variables.EDITOR = "hx";

  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
  ];
}
