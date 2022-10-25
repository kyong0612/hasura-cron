FROM hasura/graphql-engine:v2.8.0.cli-migrations-v3

ENV HASURA_GRAPHQL_UNAUTHENTICATED_ROLE=admin
ENV HASURA_GRAPHQL_ENABLED_LOG_TYPES="startup, http-log, webhook-log, websocket-log, query-log"

COPY . /app


RUN apt-get update

# crond
RUN apt-get install -y cron
COPY crontab /etc/cron.d/crontab
RUN chmod 0644 /etc/cron.d/crontab

# Running crontab
RUN crontab /etc/cron.d/crontab



# superpisor
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime


# DEBUG
RUN apt-get install -y vim



CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]