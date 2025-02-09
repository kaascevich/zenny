# shellcheck shell=sh

mntdir=/btrfs_tmp
days_until_delete=7

mkdir -p $mntdir
mount -o subvol=/ /dev/mapper/crypt $mntdir

if [ -e $mntdir/rootfs ]; then
  mkdir -p $mntdir/old_roots
  timestamp=$(date --date="@$(stat -c %Y $mntdir/rootfs)" "+%Y-%m-%-d_%H:%M:%S")
  mv $mntdir/rootfs "$mntdir/old_roots/$timestamp"
fi

delete_subvolumes() {
  IFS='
' # newline

  for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
    delete_subvolumes "$mntdir/$i"
  done

  btrfs subvolume delete "$1" > /dev/null
}

# shellcheck disable=SC2044
for i in $(find $mntdir/old_roots/ -maxdepth 1 -mtime +$days_until_delete); do
  delete_subvolumes "$i"
done

btrfs subvolume create $mntdir/rootfs > /dev/null
umount $mntdir
