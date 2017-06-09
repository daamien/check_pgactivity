
C=./check_pgactivity 

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
8.2: 8.1 last_vacuum last_analyze
8.1: 8.0 autovacuum
8.0: 7.4
7.4: all

all: archive_folder


archive_folder:
#	$C -s archive_folder --path /var/lib/postgres/pg_xlog

autovacuum:
	$C -s autovacuum

last_analyze:
	$C -s last_vacuum --status-file `mktemp` -h localhost -w 30m -c 1h30m

last_vacuum:
	$C -s last_vacuum --status-file `mktemp` -h localhost -w 30m -c 1h30m

 
