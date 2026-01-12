{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
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
    nixos-hardware,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    globalModules = [
      ./modules/users
      ./modules/nushell
      ./modules/direnv
      ./modules/yazi
      ./modules/gitui
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
      ./modules/imv
      ./modules/mpv
      ./modules/firefox
      ./modules/vesktop
      ./modules/steam
      ./modules/obs
      ./modules/osu
      ./modules/samply
      ./modules/python
      ./modules/minecraft
    ];
  in {
    nixosConfigurations.blockog-laptop = nixpkgs.lib.nixosSystem (let
      modules = builtins.concatLists [
        globalModules
        [
          ./modules/brightnessctl
        ]
      ];
    in {
      system = system;
      specialArgs = {inherit inputs;};
      modules = builtins.concatLists [
        [
          nixos-hardware.nixosModules.lenovo-ideapad-slim-5
          ./hardware-configuration-laptop.nix
          home-manager.nixosModules.home-manager
          ({pkgs, ...}: {
            nix.settings.experimental-features = ["nix-command" "flakes"];
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
      modules = builtins.concatLists [
        globalModules
        [
          ./modules/niri-desktop
        ]
      ];
    in {
      system = system;
      specialArgs = {inherit inputs;};
      modules = builtins.concatLists [
        [
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-gpu-amd
          nixos-hardware.nixosModules.common-pc-ssd
          ./hardware-configuration-desktop.nix
          home-manager.nixosModules.home-manager
          ({pkgs, ...}: {
            nix.settings.experimental-features = ["nix-command" "flakes"];
            boot.loader.systemd-boot.enable = true;
            boot.loader.efi.canTouchEfiVariables = true;
            boot.kernelPackages = pkgs.linuxPackages_latest;

            fileSystems."/".options = ["noatime"];

            networking.hostName = "blockog-desktop";
            networking.wireless.enable = true;
            networking.wireless.userControlled.enable = true;
            hardware.bluetooth.enable = true;

            services.automatic-timezoned.enable = true;

            services.upower.enable = true;
            services.dbus.implementation = "broker";

            hardware.amdgpu.opencl.enable = true;
            hardware.wooting.enable = true;

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
