run:
	docker-compose build --no-cache && \
	docker compose 
	
hasura-helth-check:
	curl http://127.0.0.1:8080/healthz