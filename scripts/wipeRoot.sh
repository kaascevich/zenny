# shellcheck shell=bash

mntdir="/btrfs_tmp"
days_until_delete="7"

print_status() {
  message=$1
  escape=$2
  printf "impermanence: \e[%sm%s\e[0m\n" "$escape" "$message"
}

print_status "mounting..." "33"
mkdir "$mntdir"
mount /dev/mapper/crypt "$mntdir"

if [[ -e "$mntdir/root" ]]; then
  print_status "backing up root..." "33"

  mkdir -p "$mntdir/old_roots"
  timestamp=$(date --date="@$(stat -c %Y "$mntdir/root")" "+%Y-%m-%-d_%H:%M:%S")
  path="$mntdir/old_roots/$timestamp"
  mv "$mntdir/root" "$path"

  print_status "backed up root to $path" "1;32"
fi

delete_subvolumes() {
  IFS=$'\n'
  for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
    delete_subvolumes "$mntdir/$i"
  done

  print_status "deleting subvolume $1..." "31"
  btrfs subvolume delete "$1"
  print_status "deleted subvolume $1" "1;31"
}

print_status "deleting root backups older than $days_until_delete days..." "31"

# shellcheck disable=SC2207
old_backups=(
  $(find "$mntdir/old_roots/" -maxdepth 1 -mtime "+$days_until_delete")
)
print_status "found ${#old_backups[@]} backups" "31"
for i in "${old_backups[@]}"; do
  delete_subvolumes "$i"
done

print_status "recreating root subvolume..." "33"
btrfs subvolume create "$mntdir/root"
print_status "recreated root subvolume" "1;33"

print_status "unmounting..." "33"
umount "$mntdir"

print_status "wipe complete! resuming boot..." "1;32"
