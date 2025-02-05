# shellcheck shell=bash

daysUntilDelete=7

printStatus() {
  message=$1
  color=$2
  printf "impermanence: \e[1;%sm%s\e[0m\n" "$color" "$message"
}

printStatus "mounting..." 33
mkdir /btrfs_tmp
mount /dev/mapper/crypt /btrfs_tmp

if [[ -e /btrfs_tmp/root ]]; then
  printStatus "backing up root..." 33

  mkdir -p /btrfs_tmp/old_roots
  timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
  path="/btrfs_tmp/old_roots/$timestamp"
  mv /btrfs_tmp/root "$path"

  printStatus "backed up root to $path" 32
fi

delete_subvolumes() {
  IFS=$'\n'
  for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
    delete_subvolumes "/btrfs_tmp/$i"
  done

  printStatus "deleting subvolume $1..." 31
  btrfs subvolume delete "$1"
  printStatus "deleted subvolume $1" 31
}

printStatus "deleting root backups older than $daysUntilDelete days..." 31

# shellcheck disable=SC2044
for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime "+$daysUntilDelete"); do
  delete_subvolumes "$i"
done

printStatus "deleting root subvolume..." 31
delete_subvolumes "/btrfs_tmp/root/"
printStatus "deleted root subvolume" 31

printStatus "recreating root subvolume..." 33
btrfs subvolume create /btrfs_tmp/root
printStatus "recreated root subvolume" 33

printStatus "unmounting..." 33
umount /btrfs_tmp

printStatus "wipe complete! resuming boot..." 32
