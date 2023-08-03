FROM openliberty/open-liberty:full-java11-openj9-ubi

COPY --chown=1001:0 src/main/liberty/config/server.xml /config/server.xml
COPY --chown=1001:0 src/main/liberty/config/server.env /config/server.env
COPY --chown=1001:0 target/io.openliberty.sample.daytrader10.war /config/apps/

# This script will add the requested XML snippets to enable Liberty features and grow image to be fit-for-purpose using featureUtility
RUN features.sh

#Derby
COPY --chown=1001:0 target/liberty/wlp/usr/shared/resources/DerbyLibs/derby-10.14.2.0.jar /opt/ol/wlp/usr/shared/resources/DerbyLibs/derby-10.14.2.0.jar
COPY --chown=1001:0 target/liberty/wlp/usr/shared/resources/data /opt/ol/wlp/usr/shared/resources/data

RUN configure.sh
