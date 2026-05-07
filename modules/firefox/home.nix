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
        "{b285d6d2-4311-418a-b5b4-cc9953c7b833}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/4636505/latest.xpi";
          installation_mode = "force_installed";
        };
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "force_installed";
        };
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };
        "DesModder@jared-hughes.github.io" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/desmodder-for-desmos/latest.xpi";
          installation_mode = "force_installed";
        };
        "support@youtuberowfixer.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-row-fixer-add-on/latest.xpi";
          installation_mode = "force_installed";
        };
      };

      Preferences = {
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
