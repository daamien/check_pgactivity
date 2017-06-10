
ifeq ($(PG_VERSION),)
PG_VERSION := 9.6
endif

CONTAINER=test_check_pgactivity_$(PG_VERSION)

test:
	docker run -d --name $(CONTAINER) postgres:$(PG_VERSION)
	docker cp . $(CONTAINER):/tmp/
	# wait for the database to come up
	sleep 10
	docker exec $(CONTAINER) bash -x /tmp/test.sh $(PG_VERSION)
	docker rm -f $(CONTAINER)

