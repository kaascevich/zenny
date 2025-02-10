{ config, lib, pkgs, ... }: {
  console.earlySetup = true;
  catppuccin = {
    enable = true;
    flavor = "mocha";
  };
}
