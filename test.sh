#!/bin/bash

HOST=localhost
STATUS_FILE=/tmp/check_pgactivity.data
C=`dirname $0`/check_pgactivity 

#latest: 9.6
#9.6: 9.5 
#9.5: 9.4
#9.4: 9.3
#9.3: 9.2
#9.2: 9.1
#9.1: 9.0
#9.0: 8.4
#8.4: 8.3
#8.3: 8.2 
#8.2: 8.1 last_vacuum last_analyze backends_status
#8.1: 8.0 autovacuum
#8.0: 7.4
#7.4: all

#all: archive_folder backends

# archive_folder      
#$C -s archive_folder --path /var/lib/postgres/pg_xlog

$C -s backends -h $HOST -w '10%' -c '30%'

$C -s backends_status -h $HOST -w 'waiting=5,idle_xact=10' -c 'waiting=20,idle_xact=30'

[[ "$1" == "7.4" ]] &&  exit 0
 
[[ "$1" == "8.0" ]] &&  exit 0

#autovacuum:
$C -s autovacuum -h $HOST



$C -s last_analyze --status-file /tmp/check_pgactivity.data -h $HOST -w 30m -c 1h30m
$C -s last_vacuum --status-file /tmp/check_pgactivity.data  -h $HOST -w 30m -c 1h30m

 
