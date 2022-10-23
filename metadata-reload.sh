#!/bin/sh -ex

ROOT=$(cd $(dirname "$0"); pwd)

if [ ! -e "$ROOT"/metadata ]; then
  echo "metadata not found"
  exit 1
fi

if [ -z "$HASURA_GRAPHQL_ENDPOINT" ]; then
  echo "HASURA_GRAPHQL_ENDPOINT not set"
  exit 1
fi

echo "$HASURA_GRAPHQL_ENDPOINT"

hasura-cli metadata reload \
  --project "$ROOT" \
  --endpoint "$HASURA_GRAPHQL_ENDPOINT" \
  --skip-update-check