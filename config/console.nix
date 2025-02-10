{ config, lib, pkgs, ... }: {
  console = {
    earlySetup = true;
    colors = [
      "45475a" # black
      "f38ba8" # red
      "a6e3a1" # green
      "f9e2af" # yellow
      "89b4fa" # blue
      "f5c2e7" # magenta
      "94e2d5" # cyan
      "bac2de" # white
      "585b70" # bright black
      "f38ba8" # bright red
      "a6e3a1" # bright green
      "f9e2af" # bright yellow
      "89b4fa" # bright blue
      "f5c2e7" # bright magenta
      "94e2d5" # bright cyan
      "a6adc8" # bright white
    ];
  };
}
