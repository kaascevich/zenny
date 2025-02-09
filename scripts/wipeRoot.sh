# shellcheck shell=sh

print_status() {
  printf "impermanence: \e[1;32m%s\e[0m\n" "$1"
}

mntdir=/btrfs_tmp
days_until_delete=7

print_status "mounting..."
mkdir -p $mntdir
mount /dev/mapper/crypt $mntdir

if [ -e $mntdir/rootfs ]; then
  print_status "backing up root..."
  mkdir -p $mntdir/old_roots
  timestamp=$(date --date="@$(stat -c %Y $mntdir/rootfs)" "+%Y-%m-%-d_%H:%M:%S")
  mv $mntdir/rootfs "$mntdir/old_roots/$timestamp"
fi

delete_subvolumes() {
  IFS='
'

  for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
    delete_subvolumes "$mntdir/$i"
  done

  print_status "deleting subvolume '$1'..."
  btrfs subvolume delete "$1"
}

print_status "deleting backups older than $days_until_delete days..."
# shellcheck disable=SC2044
for i in $(find $mntdir/old_roots/ -maxdepth 1 -mtime +$days_until_delete); do
  delete_subvolumes "$i"
done

print_status "recreating root subvolume..."
btrfs subvolume create $mntdir/rootfs

print_status "unmounting..."
umount $mntdir

print_status "wipe complete! resuming boot..."
