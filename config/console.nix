{ config, lib, pkgs, ... }: {
  console.earlySetup = true;

  services.kmscon = {
    enable = true;
    fonts = [{
      name = "Cascadia Code";
      package = pkgs.cascadia-code;
    }];
  }
}
