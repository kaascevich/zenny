# shellcheck shell=busybox

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
  IFS=$(printf " \n\t")
  btrfs subvolume list -o "$1" | cut -f9 -d' ' | while read -r subvolume; do
    delete_subvolumes "$mntdir/$subvolume"
  done

  print_status "deleting subvolume '$1'..." "31"
  btrfs subvolume delete "$1"
  print_status "deleted subvolume '$1'" "1;31"
}

delete_old_backups() {
  print_status "deleting root backups older than $days_until_delete days..." "31"

  old_backups=$(
    find "$mntdir/old_roots/" -maxdepth 1 -mtime "+$days_until_delete"
  )

  # shellcheck disable=SC2086 # word splitting is exactly what we want here
  set -- $old_backups
  print_status "found $# old backups" "31"

  # shellcheck disable=SC2068
  for i in $@; do
    delete_subvolumes "$i"
  done
}

delete_old_backups
delete_subvolumes "$mntdir/root"

print_status "recreating root subvolume..." "33"
btrfs subvolume create "$mntdir/root"
print_status "recreated root subvolume" "1;33"

print_status "unmounting..." "33"
umount "$mntdir"

print_status "wipe complete! resuming boot..." "1;32"
