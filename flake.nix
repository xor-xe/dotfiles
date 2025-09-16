{

 description = "My First flake";

 inputs = {
  nixpkgs.url = "nixpkgs/nixos-25.05"; # where nix packages are being installed from
  hyprland.url = "github:hyprwm/Hyprland";
  home-manager.url = "github:nix-community/home-manager/release-25.05"; # home manager has seperate installation source
  home-manager.inputs.nixpkgs.follows = "nixpkgs"; # make sure that version is same for homeanager and nixpkgs
  quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

      # THIS IS IMPORTANT
      # Mismatched system dependencies will lead to crashes and other issues.
      inputs.nixpkgs.follows = "nixpkgs";
    };
 };

 outputs = {self, nixpkgs, home-manager, hyprland, quickshell, ... }: #args of packages used down the line
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
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
      extraSpecialArgs = { inherit quickshell; };
      modules = [ ./home.nix ]; #file inside .dotfiles
    };
  };
 };

}
