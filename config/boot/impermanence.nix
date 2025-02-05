{ config, lib, pkgs, ... }: {
  boot.initrd.postResumeCommands =
    lib.mkAfter <| builtins.readFile ../../scripts/wipeRoot.sh;
}
