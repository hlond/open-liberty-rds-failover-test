# Open Liberty RDS Failover Test

A minimal project running in Open Liberty and using the AWS Advanced JDBC Wrapper for the purpose of testing RDS failover capabilities.

## Prerequisites

To conduct the test scenario provided by this project, the following requirements must be met

- AWS RDS cluster is available
- awscli is installed
- docker is installed

## Configuration

The application can be configured via the `.env` file

```bash
echo "# Database config" >> .env
echo "DB_HOST=<rds-cluster-host>" >> .env
echo "DB_USER=<db-user/iam user>" >> .env
echo "DB_PASS=<db-pass>" >> .env
echo "DB_NAME=<db-name>" >> .env
echo "DB_PROPERTIES=wrapperPlugins: auroraConnectionTracker,efm2,failover2,iam; wrapperDialect: aurora-pg; failureDetectionCount: 1; failureDetectionInterval: 500; failoverTimeoutMs: 30000; failoverWriterReconnectIntervalMs: 1000; failoverReaderConnectTimeoutMs: 1000; failoverClusterTopologyRefreshRateMs: 1000; stringType: unspecified" >> .env
echo "" >> .env
echo "RDS_CLUSTER_IDENTIFIER=<rds-cluster-identifier>" >> .env
echo "" >> .env
echo "AWS_REGION=<region>" >> .env
echo "# AWS authentication: aws configure export-credentials --format env-no-export" >> .env
echo "AWS_ACCESS_KEY_ID=" >> .env
echo "AWS_SECRET_ACCESS_KEY=" >> .env
echo "AWS_SESSION_TOKEN=" >> .env
echo "AWS_CREDENTIAL_EXPIRATION=" >> .env
```

## Build and Run Locally

The application can be build using docker

```bash
docker compose build --build-arg AWS_ADVANCED_JDBC_WRAPPER_VERSION=3.3.0
```

To serve it at 9080, run

```bash
docker compose up
```

The test-endpoint is available at

```bash
curl http://localhost:9080/wrapper-test
```

## Run Simulated Failover Scenario

To perform a simulated failover scenario, run

```bash
./failover_test.sh
```
