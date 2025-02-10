{ config, lib, pkgs, ... }: {
  console = {
    earlySetup = true;
    packages = with pkgs; [ terminus_font ];
    font = "ter-i32b";
  };
}
