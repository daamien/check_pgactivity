
HOST=localhost
STATUS_FILE=/tmp/check_pgactivity.data
C=@./check_pgactivity 

test: latest

latest: 9.6
9.6: 9.5 
9.5: 9.4
9.4: 9.3
9.3: 9.2
9.2: 9.1
9.1: 9.0
9.0: 8.4
8.4: 8.3
8.3: 8.2 
8.2: 8.1 last_vacuum last_analyze backends_status
8.1: 8.0 autovacuum
8.0: 7.4
7.4: all

all: archive_folder backends


archive_folder:
#	$C -s archive_folder --path /var/lib/postgres/pg_xlog

autovacuum:
	$C -s autovacuum -h $(HOST)

backends:
	$C -s backends -h $(HOST) -w 'waiting=5,idle_xact=10' -c 'waiting=20,idle_xact=30'

backends_status:
	$C -s backends_status -h $(HOST) -w 'waiting=5,idle_xact=10' -c 'waiting=20,idle_xact=30'

last_analyze:
	$C -s last_vacuum --status-file /tmp/check_pgactivity.data -h $(HOST) -w 30m -c 1h30m

last_vacuum:
	$C -s last_vacuum --status-file /tmp/check_pgactivity.data  -h $(HOST) -w 30m -c 1h30m

 
