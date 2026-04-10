#!/bin/bash

# Runs the k6 suite against wrapper-test endpoint. After 10 seconds, it triggers a failover of the RDS cluster
# with the cluster identifier $RDS_CLUSTER_IDENTIFIER.
# Arguments of this command are passed to the k6 run command.
#
# Examples:
#
#   ./failover_test.sh
#   ./failover_test.sh --vus=10 --duration=100s

set -a
source .env
set +a

if [ -z "${RDS_CLUSTER_IDENTIFIER}" ]; then
  echo "Environment RDS_CLUSTER_IDENTIFIER is required."
  exit 1
fi

docker run -v ./k6:/home/k6/tests:ro --network wrapper-test \
  docker.io/grafana/k6 run tests/endpoint-wrapper-test.js "${@}" &
K6_PID=$!
echo "k6 run with PID $K6_PID. waiting 10s to do failover."

sleep 10

echo "Triggering failover."

aws rds failover-db-cluster --db-cluster-identifier ${RDS_CLUSTER_IDENTIFIER}

wait $K6_PID
echo "Done. k6 exit code: $?"
