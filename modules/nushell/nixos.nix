{pkgs, ...}: {
  environment.systemPackages = with pkgs; [nushell];
  users.users.blockog.shell = pkgs.nushell;
}
