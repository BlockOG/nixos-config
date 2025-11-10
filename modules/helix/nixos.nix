{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [helix];
  environment.variables.EDITOR = "hx";

  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
  ];
}
