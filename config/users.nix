{ config, lib, pkgs, ... }: {
  users = {
    mutableUsers = false;
    users.kaleb = {
      description = "Kaleb A. Ascevich";
      isNormalUser = true;

      home = "/home/kaleb";
      createHome = true;

      extraGroups = [ "wheel" ];
      initialHashedPassword = "$y$j9T$joMu5gyUwnGVet8lwCckB0$o/k/B1BR8NiQ0xU6NgfBKxn5pnUpTmcaseUjGH2LTA5";

      shell = pkgs.nushell;
    };
  };
}
