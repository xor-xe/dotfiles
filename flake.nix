{

 description = "My First flake";

 inputs = {
  nixpkgs.url = "nixpkgs/nixos-25.05"; # where nix packages are being installed from
  nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  hyprland.url = "github:hyprwm/Hyprland";
  home-manager.url = "github:nix-community/home-manager/release-25.05"; # home manager has seperate installation source
  home-manager.inputs.nixpkgs.follows = "nixpkgs"; # make sure that version is same for homeanager and nixpkgs
  quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";  # Or github:quickshell-mirror/quickshell
      inputs.nixpkgs.follows = "nixpkgs";  # Critical: Matches NixOS deps to avoid crashes
    };
 };

 outputs = {self, nixpkgs, home-manager, hyprland, quickshell, nixpkgs-unstable, ... }: #args of packages used down the line
  let
    projectName = "mariage";
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pkgsUnstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true; # Necessary for Cursor
    };
  in {
  nixosConfigurations = {
    nixos = lib.nixosSystem {
      inherit system; # takes system as arg
      specialArgs = { inherit hyprland; }; # pass hyprland for conigurarion so that it will use special hyprland git repository as source
      modules = [ ./configuration.nix ]; #file inside .dotfiles
    };
  };
  homeConfigurations = { # home config for user
    xorxe = home-manager.lib.homeManagerConfiguration {
      inherit pkgs; # takes pkgs as args but as var from let binding above
      extraSpecialArgs = { inherit quickshell; inherit pkgsUnstable; inherit projectName; };
      modules = [ ./home.nix ]; #file inside .dotfiles
    };
  };
 };

}
