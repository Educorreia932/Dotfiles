{ config, pkgs, ... }:

{
  imports = [ 
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix> 
    ./hardware-configuration.nix
  ];
}
