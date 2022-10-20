run:
	docker build . -t hasura-image --progress plain && \
	docker run -p 8080:8080 \
  -e HASURA_GRAPHQL_DATABASE_URL=postgres://postgres:password@postgres:5432/postgres \
  -e HASURA_GRAPHQL_ENABLE_CONSOLE=true \
  hasura-image

postgres:
	docker run --name postgres \
		-e POSTGRES_PASSWORD=password \
		-e POSTGRES_INITDB_ARGS="--encoding=UTF8 --no-locale" \
		-e TZ=Asia/Tokyo \
		-v postgresdb:/var/lib/postgresql/data \
		-p 5432:5432 \
		-d postgres