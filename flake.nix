{
  description = "Shebang's redone Nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Impermanence for immutable(ish) system
    impermanence.url = "github:nix-community/impermanence";

    # Webcord Nix Package
    webcord.url = "github:fufexan/webcord-flake";

    nur.url = "github:nix-community/NUR";

    # Grimblast, some other packages
    hyprwm-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix Formatter
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    impermanence,
    alejandra,
    nur,
    ...
  } @ inputs: {
    nixosConfigurations = {
      # Laptop Config for a heavily modified Thinkpad T430
      np-t430 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;}; # Pass flake inputs to our config
        # > Our main nixos configuration file <
        modules = [./hosts/common/configuration.nix ./hosts/np-t430/configuration.nix];
      };
      np-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;}; # Pass flake inputs to our config
        # > Our main nixos configuration file <
        modules = [./hosts/common/configuration.nix ./hosts/np-desktop/configuration.nix];
      };
    };

    homeConfigurations = {
      "shebang@np-t430" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs;
          host = {
            hostName = "np-t430";
          };
        }; # Pass flake inputs to our config
        # > Our main home-manager configuration file <
        modules = [./home-manager/home.nix];
      };
      "shebang@np-desktop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs;
          host = {
            hostName = "np-desktop";
          };
        }; # Pass flake inputs to our config
        # > Our main home-manager configuration file <
        modules = [./home-manager/home.nix];
      };
    };
  };
}
