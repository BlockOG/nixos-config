{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git-credential-manager
    git-crypt
  ];

  programs.git.enable = true;
  programs.git.config.init.defaultBranch = "main";
  programs.git.config.credential.helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
  programs.git.config.credential.credentialStore = "secretservice";
}
