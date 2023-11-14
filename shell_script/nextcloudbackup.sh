#!/bin/sh

rsync -avz --delete /var/www/html/nextcloud/data /mnt/d/nextcloud_backup &&

exit 0

