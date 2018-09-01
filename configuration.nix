{pkgs, ...} :
{
  imports = [ <nixpkgs/nixos/modules/virtualisation/amazon-image.nix> ];
  ec2.hvm = true;
  networking.hostName = "jhrcek-aws-1";
  system.stateVersion = "18.03";
  environment.systemPackages = [ pkgs.vim pkgs.htop ]; # The set of packages that appear in /run/current-system/sw. These packages are automatically available to all users, and are automatically updated every time you rebuild the system configuration.
  services.openssh.passwordAuthentication = false; # Specifies whether password authentication is allowed.
  security.sudo.wheelNeedsPassword = false; # Whether users of the wheel group must provide a password to run commands as super user via sudo.
  nix.trustedUsers = [ "@wheel" ]; # A list of names of users that have additional rights when connecting to the Nix daemon, such as the ability to import unsigned NARs. @wheel means all users in the wheel group.

  users.users.jhrcek = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
     "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6oxn782n675fFgNpTlhzwpdj9cJoExovEMgLx8bKLpPtQgcSMyHDY9zDMzZRVXiZtWHxYmY5mMHiw9AiN+O2CmMzypggcQR1btteLzgKYQIguMWKnwDkLN7J3RqGJxB9eO1zwrlDRxTtCrRNjPwk10vY2i4VjaVMzhh52k1XRSgLptxLrFojD/6W4OhR0uTYhnXo5FcS7F4TFXs9JNO+w9wF4cRM0XpRQg+eCgwzrq2ysFCtzTMa9qrgiqzZq3jDt/zUu70lxqYZQcd7tRCBaLDiScThXaghLkmVa5824NoMFoYcwbz7aD2VMuTzAzJ308bSDC/zx/oXHn55Uif97 jhrcek@redhat.com"
    ];
  };
}
