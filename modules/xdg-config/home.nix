{config, ...}: {
  xdg.userDirs = {
    enable = true;
    setSessionVariables = true;
    download = "${config.home.homeDirectory}/downloads";
    documents = "${config.home.homeDirectory}/documents";
    videos = "${config.home.homeDirectory}/videos";
    music = "${config.home.homeDirectory}/music";
  };
}
