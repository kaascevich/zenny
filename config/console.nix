{ config, lib, pkgs, ... }: {
  console = {
    earlySetup = true;
    # packages = with pkgs; [ cascadia-code ];
    # font = "cascadia-code";
  };
}
