{pkgs, ...}: {
  home.packages = with pkgs; [
    (rust-bin.stable.latest.default.override {
      extensions = [
        "rust-src"
        "rust-analyzer"
      ];
    })
    clang-tools
    nixd
    alejandra
  ];

  programs.helix.enable = true;
  programs.helix = {
    settings = {
      theme = "catppuccin_mocha";
    };

    languages.language = [
      {
        name = "cpp";
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }
      {
        name = "nix";
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        formatter = {
          command = "alejandra";
          args = ["-"];
        };
        auto-format = true;
      }
    ];
  };

  programs.nushell.environmentVariables.EDITOR = "hx";
}
