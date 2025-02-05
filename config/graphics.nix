{ config, lib, pkgs, ... }: {
  hardware.graphics.enable = true; # OpenGL

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
