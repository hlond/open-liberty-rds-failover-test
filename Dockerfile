# build library needed for Open Liberty data source (contains aws-advanced-jdbc-wrapper and postgresql driver)
FROM maven:3.9.14-eclipse-temurin-17-noble AS aws-advanced-jdbc-wrapper

ARG AWS_ADVANCED_JDBC_WRAPPER_VERSION=3.3.0

COPY docker/pom-aws-wrapper.xml /tmp/pom.xml
RUN AWS_ADVANCED_JDBC_WRAPPER_VERSION=${AWS_ADVANCED_JDBC_WRAPPER_VERSION} \
      mvn -f /tmp/pom.xml war:exploded

# build the application
FROM maven:3.9.14-eclipse-temurin-17-noble AS application

COPY docker/pom-wrapper-test.xml /tmp/pom.xml
COPY src /tmp/src
RUN mvn -f /tmp/pom.xml compile package

# build open-liberty with libraries and application
FROM open-liberty:kernel-slim-java17-openj9

COPY docker/config/* /config/
RUN features.sh

COPY --from=aws-advanced-jdbc-wrapper /tmp/target/aws-advanced-jdbc-wrapper-1.0-SNAPSHOT/WEB-INF/lib/ /config/aws-advanced-jdbc-wrapper/
COPY --from=application /tmp/target/wrapper-test.war /config/dropins/

EXPOSE 9080

CMD ["server", "run", "defaultServer"]
