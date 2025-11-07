{lib, ...}: {
  programs.firefox = {
    enable = true;
    languagePacks = ["en-US"];

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
      };
      DisablePocket = true;
      OverrideFirstRunPage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "newbar";
      DisplayMenuBar = "never";
      SearchBar = "unified";
      DefaultDownloadDirectory = "\${home}/downloads";

      ExtensionSettings = {
        "*".installation_mode = "blocked";
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "FirefoxColor@mozilla.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/firefox-color/latest.xpi";
          installation_mode = "force_installed";
        };
      };

      Preferences = {
        "browser.download.folderList" = 2; # apply new downloads folder
        "browser.startup.page" = 3; # restore previous tabs
        "browser.tabs.insertAfterCurrent" = true;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["ublock0_raymondhill_net-browser-action"],"nav-bar":["back-button","forward-button","vertical-spacer","urlbar-container","downloads-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs"],"vertical-tabs":[],"PersonalToolbar":["personal-bookmarks"]},"seen":["developer-button","screenshot-button","ublock0_raymondhill_net-browser-action"],"dirtyAreaCache":["nav-bar","vertical-tabs","PersonalToolbar","toolbar-menubar","TabsToolbar","unified-extensions-area"],"currentVersion":23,"newElementCount":5}'';
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };

    profiles.default = {
      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";
      };

      extensions = {
        force = true;
        # packages = with pkgs.nur.repos.rycee.firefox-addons; [
        # 	ublock-origin
        # 	firefox-color
        # ];
        settings = {
          "FirefoxColor@mozilla.com".settings = lib.importJSON ./firefox-color.json;
        };
      };

      userChrome = ''.titlebar-spacer, .titlebar-buttonbox-container { display: none; } .tab-label { color: #BCECFF; } .tab-label[selected] { color: #F5A9B8; } .tab-close-button { display: none; } #scrollbutton-up, #scrollbutton-down { display: none; }'';
      userContent = ''@-moz-document url(about:newtab) { .personalizeButtonWrapper { display: none !important; } }'';
    };
  };
}
