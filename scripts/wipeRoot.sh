# shellcheck shell=busybox

DEBUG="true"
[[ $DEBUG == "true" ]] && set -x

days_until_delete="7"

print_status() {
  message=$1
  escape=$2
  printf "impermanence: \e[%sm%s\e[0m\n" "$escape" "$message"
}

print_status "mounting..." "32"
mkdir -p /mnt
mount -o subvol=/ /dev/mapper/crypt /mnt

if [[ -e "/mnt/root" ]]; then
  print_status "backing up root..." "32"

  timestamp=$(date --date="@$(stat -c %Y /mnt/root)" "+%Y-%m-%-d_%H:%M:%S")
  path="/mnt/old_roots/$timestamp"
  mkdir -p "$path"
  mv /mnt/root/* "$path"
fi

delete_subvolumes() {
  IFS=$(printf " \n\t")
  btrfs subvolume list -o "$1" | cut -f 9 -d ' ' | while read -r subvolume; do
    delete_subvolumes "/mnt/$subvolume"
  done

  print_status "deleting subvolume '$1'..." "32"
  btrfs subvolume delete "$1" > /dev/null
}

delete_old_backups() {
  print_status "deleting backups older than $days_until_delete days..." "32"

  old_backups=$(
    find /mnt/old_roots/ -maxdepth 1 -mtime "+$days_until_delete"
  )

  # shellcheck disable=SC2086 # word splitting is exactly what we want here
  set -- $old_backups
  print_status "found $# old backups" "32"

  for i in "$@"; do
    delete_subvolumes "$i"
  done
}

delete_old_backups
delete_subvolumes /mnt/root

print_status "recreating root subvolume..." "32"
btrfs subvolume create /mnt/root > /dev/null

print_status "unmounting..." "32"
umount /mnt

if [[ $DEBUG == "true" ]]; then
  print_status "wipe complete! press enter to resume boot..." "1;32"
  read -r -p "" _
else
  print_status "wipe complete! resuming boot..." "1;32"
fi
