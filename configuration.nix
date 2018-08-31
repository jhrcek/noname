{
  imports = [ <nixpkgs/nixos/modules/virtualisation/amazon-image.nix> ];
  ec2.hvm = true;
  networking.hostName = "jhrcek-aws-1";
  system.stateVersion = "18.03";
}
