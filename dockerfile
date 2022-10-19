FROM hasura/graphql-engine:v2.8.0.cli-migrations-v3

ENV HASURA_GRAPHQL_UNAUTHENTICATED_ROLE=admin
ENV HASURA_GRAPHQL_ENABLED_LOG_TYPES="startup, http-log, webhook-log, websocket-log, query-log"

RUN echo "🎉 Starting Hasura GraphQL Engine..."

# superpisor
RUN apt-get update && apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]