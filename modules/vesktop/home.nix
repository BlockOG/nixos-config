{lib, ...}: {
  programs.vesktop.enable = true;
  programs.vesktop = {
    settings = {
      tray = false;
      enableMenu = false;
      enableSplashScreen = false;
      spellCheckLanguages = ["en-US"];
    };

    vencord.settings = lib.importJSON ../../secret-modules/vesktop/vencord-settings.json;
  };
}
