#!/bin/bash

set -e
export PGPASSWORD=$POSTGRES_PASSWORD

while ! psql -h db_primary -U $POSTGRES_USER -d $POSTGRES_DB -p 5432 -c "select 'it is running';" 2>&1 ; do \
	sleep 1s ; \
done

# Delete
rm -rf $PGDATA/*

# Backup Directory
export WALARCHIVE=/backup/postgres/archived_xlog
mkdir -p $WALARCHIVE
chown postgres:postgres $WALARCHIVE
chmod 700 $WALARCHIVE

# load backup from primary instance
pg_basebackup -h db_primary -p 5432 -D $PGDATA -S replication_slot_slave1 --progress -X stream -U replicator -Fp -R || :

# start postgres
bash /usr/local/bin/docker-entrypoint.sh -c 'config_file=/etc/postgresql/postgresql.conf' -c 'hba_file=/etc/postgresql/pg_hba.conf'