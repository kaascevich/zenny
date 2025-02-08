# shellcheck shell=busybox

DEBUG="true"
if [[ $DEBUG == "true" ]]; then
  set -x
  trap "set +x" EXIT
fi

print_status() {
  message=$1
  escape=$2
  printf "impermanence: \e[%sm%s\e[0m\n" "$escape" "$message"
}

print_status "mounting..." "32"
mkdir -p /mnt
mount -o subvol=/ /dev/mapper/crypt /mnt

btrfs subvolume list -o /mnt/root | cut -f 9 -d ' ' | while read -r subvolume; do
  print_status "deleting subvolume '$subvolume'..." "32"
  btrfs subvolume delete "/mnt/$subvolume"
done &&
print_status "deleting root subvolume..." "32" &&
btrfs subvolume delete /mnt/root

print_status "restoring blank root subvolume..." "32"
btrfs subvolume snapshot /mnt/blankroot /mnt/root

print_status "unmounting..." "32"
umount /mnt

if [[ $DEBUG == "true" ]]; then
  print_status "wipe complete! press enter to resume boot..." "1;32"
  read -r -p "" _
else
  print_status "wipe complete! resuming boot..." "1;32"
fi
