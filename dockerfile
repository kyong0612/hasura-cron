FROM hasura/graphql-engine:v2.8.0.cli-migrations-v3

ENV HASURA_GRAPHQL_UNAUTHENTICATED_ROLE=admin
ENV HASURA_GRAPHQL_ENABLED_LOG_TYPES="startup, http-log, webhook-log, websocket-log, query-log"

RUN echo "🎉 Starting Hasura GraphQL Engine..."

RUN apt-get update

# crond
RUN apt-get install -y cron
# RUN sed -i -e '/pam_loginuid.so/s/^/#/' /etc/pam.d/crond
COPY cron.conf /etc/cron.d/cron
# ログを標準出力へ出力できるようにシンボリックリンクを作成する
RUN chmod 0644 /etc/cron.d/cron && ln -sf /proc/1/fd/1 /var/log/cron.log


# superpisor
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime


CMD ["/usr/bin/supervisord"]