{ config, lib, pkgs, ... }: {
  console = {
    earlySetup = true;
    packages = with pkgs; [ terminus_font powerline-fonts ];
    font = "ter-powerline-232n";
  };
}
