#!/bin/bash

set -e

restore_backup() {
    if [ ! -f backup.qp ]
    then
        echo "backup.qp not found, aborting."
        exit
    fi

    mkdir backupdir
    xbstream -x -p 4 < ./backup.qp -C ./backupdir/
    xtrabackup --parallel 4 --decompress --target-dir=./backupdir
    find ./backupdir/ -name '*.qp' | xargs rm -f
    xtrabackup --prepare --target-dir=./backupdir
    xtrabackup --defaults-file=/etc/mysql/my.cnf --copy-back --target-dir=./backupdir
    chown -R mysql:mysql /var/lib/mysql
    rm -rf ./backupdir
}


if [ ! -f /import_done ]
then
    restore_backup
    touch /import_done
fi

source usr/local/bin/docker-entrypoint.sh
_main "$@"