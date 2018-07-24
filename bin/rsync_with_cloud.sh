#!/usr/bin/env bash
#
# Supports an encrypted tarball representing a (possibly shared)
# backup of some set of files and directories. Updates local "source"
# first with anything newer in the backup. Then updates the backup
# with anyting newer from the source. Will possibly lead to amazement
# if the same file is updated in different sources before either does
# an update.

gpg=gpg2

set -e
#set -x

if [[ -z "$1" || -z "$2" || -z "$3" ]]; then
    echo "usage: rsync_with_cloud.sh <key> <target> <file|dir ...>"
    exit 1
fi

MMI_RSYNC_KEY=$1
MMI_RSYNC_TGT=$2

temp_work="/tmp/rsync_with_cloud.$$"
mkdir $temp_work

function cleanup {
    echo "Removing $temp_work"
    rm -rf $temp_work
}
trap cleanup EXIT


if [[ -e $MMI_RSYNC_TGT ]]; then
    # decrypt into workarea and update source
    $gpg --batch --passphrase $MMI_RSYNC_KEY -d -o- $MMI_RSYNC_TGT |\
        tar -xzv -C $temp_work
    for f in ${@:3}; do
        rsync -avuP "$temp_work/$f/" "$f"
    done
fi

for f in ${@:3}; do
    # rsync into workarea
    rsync -avuP "$f" "$temp_work"
done

# encrypt workarea into target
cd $temp_work
tar czf - * | $gpg --batch --yes --passphrase $MMI_RSYNC_KEY -c -o "$MMI_RSYNC_TGT"    
