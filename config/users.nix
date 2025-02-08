{ config, lib, pkgs, ... }: with (import ../personal.nix); {
  users = {
    mutableUsers = false;
    users = {
      ${username} = {
        description = fullName;
        isNormalUser = true;

        extraGroups = [ "wheel" "networkmanager" ];
        initialHashedPassword = "$y$j9T$joMu5gyUwnGVet8lwCckB0$o/k/B1BR8NiQ0xU6NgfBKxn5pnUpTmcaseUjGH2LTA5";

        shell = pkgs.nushell;
      };
      root = {
        home = lib.mkForce "/home/root";
        createHome = true;
      };
    };
  };
}
