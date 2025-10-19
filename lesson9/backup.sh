#!/bin/bash

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIRECTORY="/opt/mysql_backup"
DB_USER="root"
DB_PASSWORD=""

DATABASES=$(mysql -u${DB_USER} -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema|mysql|sys)")

for db in $DATABASES; do
    mysqldump -u${DB_USER} --single-transaction --quick --lock-tables=false $db > ${BACKUP_DIRECTORY}/${db}_backup_${DATE}.sql
    gzip ${BACKUP_DIRECTORY}/${db}_backup_${DATE}.sql
done

echo "$(date) бекап done"