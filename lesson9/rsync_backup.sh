#!/bin/bash

BACKUP_DIRECTORY="/opt/mysql_backup"
REMOTE_USER="lolka"
REMOTE_HOST="10.211.55.30"
REMOTE_DIRECTORY="/opt/store/mysql"

rsync -avz --delete -e "ssh" ${BACKUP_DIRECTORY}/ ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIRECTORY}/

echo "$(date) rsync done"

