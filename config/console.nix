{ config, lib, pkgs, ... }: {
  console = {
    earlySetup = true;
    packages = with pkgs; [ cascadia-code ];
    font = "${pkgs.cascadia-code}/share/consolefonts/ter-132n.psf.gz";
  };
}
