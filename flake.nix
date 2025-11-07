{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    globalModules = [
      ./modules/users
      ./modules/nushell
      ./modules/direnv
      ./secret-modules/networks
      ./modules/wget
      ./modules/7zip
      ./modules/git
      ./modules/usb-drive
      ./modules/helix
      ./modules/audio
      ./modules/niri
      ./modules/quickshell
      ./modules/cursor
      ./modules/fonts
      ./modules/dark-mode
      ./modules/kitty
      ./modules/hyfetch
      ./modules/fuzzel
      ./modules/firefox
      ./modules/vesktop
      ./modules/steam
      ./modules/osu
      ./modules/samply
    ];
  in {
    nixosConfigurations.blockog-laptop = nixpkgs.lib.nixosSystem (let
      modules = globalModules;
    in {
      system = system;
      specialArgs = {inherit inputs;};
      modules = builtins.concatLists [
        [
          home-manager.nixosModules.home-manager
          ({pkgs, ...}: {
            imports = [./hardware-configuration-laptop.nix];
            nix.settings.experimental-features = ["nix-command" "flakes"];
            environment.systemPackages = with pkgs; [
              brightnessctl
            ];

            boot.loader.systemd-boot.enable = true;
            boot.loader.efi.canTouchEfiVariables = true;
            boot.kernelPackages = pkgs.linuxPackages_latest;

            networking.hostName = "blockog-laptop";
            networking.wireless.enable = true;
            networking.wireless.userControlled.enable = true;
            hardware.bluetooth.enable = true;

            services.automatic-timezoned.enable = true;

            services.upower.enable = true;
            services.dbus.implementation = "broker";

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";

              extraSpecialArgs = {inherit inputs;};
              users.blockog.imports = builtins.filter builtins.pathExists (map (p: p + "/home.nix") modules);
              users.blockog.home.stateVersion = "25.05";
            };

            system.stateVersion = "25.05";
          })
        ]
        (builtins.filter builtins.pathExists (map (p: p + "/nixos.nix") modules))
      ];
    });
    nixosConfigurations.blockog-desktop = nixpkgs.lib.nixosSystem (let
      modules = globalModules;
    in {
      system = system;
      specialArgs = {inherit inputs;};
      modules = builtins.concatLists [
        [
          home-manager.nixosModules.home-manager
          ({pkgs, ...}: {
            imports = [./hardware-configuration-desktop.nix];
            nix.settings.experimental-features = ["nix-command" "flakes"];
            environment.systemPackages = with pkgs; [
              brightnessctl
            ];

            boot.loader.systemd-boot.enable = true;
            boot.loader.efi.canTouchEfiVariables = true;
            boot.kernelPackages = pkgs.linuxPackages_latest;
            fileSystems."/".options = ["noatime"];

            networking.hostName = "blockog-desktop";
            networking.wireless.enable = true;
            networking.wireless.userControlled.enable = true;
            hardware.bluetooth.enable = true;

            services.automatic-timezoned.enable = true;

            services.dbus.implementation = "broker";

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";

              extraSpecialArgs = {inherit inputs;};
              users.blockog.imports = builtins.filter builtins.pathExists (map (p: p + "/home.nix") modules);
              users.blockog.home.stateVersion = "25.05";
            };

            system.stateVersion = "25.05";
          })
        ]
        (builtins.filter builtins.pathExists (map (p: p + "/nixos.nix") modules))
      ];
    });
  };
}
