# shellcheck shell=bash

daysUntilDelete=7

mkdir /btrfs_tmp
mount /dev/mapper/crypt /btrfs_tmp
if [[ -e /btrfs_tmp/root ]]; then
  mkdir -p /btrfs_tmp/old_roots
  timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
  mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
fi

delete_subvolumes() {
  IFS=$'\n'
  for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
    delete_subvolumes "/btrfs_tmp/$i"
  done
  btrfs subvolume delete "$1"
}

while IFS= read -r -d '' i; do
  delete_subvolumes "$i"
done < <(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime "+$daysUntilDelete")

btrfs subvolume create /btrfs_tmp/root
umount /btrfs_tmp
