apiVersion: 1

datasources:
  - name: InfluxDB
    type: influxdb
    access: proxy
    url: http://${HOSTNAME}:${DOCKER_INFLUXDB_INIT_PORT}
    jsonData:
      version: Flux
      organization: ${DOCKER_INFLUXDB_INIT_ORG}
      defaultBucket: ${DOCKER_INFLUXDB_INIT_BUCKET}
      tlsSkipVerify: true
    secureJsonData:
      token: ${DOCKER_INFLUXDB_INIT_ADMIN_TOKEN}