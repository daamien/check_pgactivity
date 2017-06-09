
C=./check_pgactivity --path /tmp/ --status-file /tmp/

test: 9.6

9.6: last_vacuum

last_vacuum:
	$C -s last_vacuum -h localhost -w 30m -c 1h30m 
