apiVersion: 1

datasources:
  - name: InfluxDB
    type: influxdb
    access: proxy
    url: http://${trimspace(data.local_file.hostname.content)}:${DOCKER_INFLUXDB_INIT_PORT}
    jsonData:
      version: Flux
      organization: ${DOCKER_INFLUXDB_INIT_ORG}
      defaultBucket: ${DOCKER_INFLUXDB_INIT_BUCKET}
      tlsSkipVerify: true
    secureJsonData:
      token: ${trimspace(data.local_file.influx_token_key.content)}