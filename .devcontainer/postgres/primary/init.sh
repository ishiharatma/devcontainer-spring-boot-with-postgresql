#!/bin/bash

set -e

# Backup Directory
export WALARCHIVE=/backup/postgres/archived_xlog
mkdir -p $WALARCHIVE
chown postgres:postgres $WALARCHIVE
chmod 700 $WALARCHIVE

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD '<your-password-here>';
  SELECT * FROM pg_create_physical_replication_slot('replication_slot_slave1');
EOSQL