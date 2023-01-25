DOCKER_INFLUXDB_INIT_MODE=${DOCKER_INFLUXDB_INIT_MODE}

## Environment variables used during the setup and operation of the stack
#

# Primary InfluxDB admin/superuser credentials
#
DOCKER_INFLUXDB_INIT_USERNAME=${DOCKER_INFLUXDB_INIT_USERNAME}
DOCKER_INFLUXDB_INIT_PASSWORD=${DOCKER_INFLUXDB_INIT_PASSWORD}
DOCKER_INFLUXDB_INIT_ADMIN_TOKEN=${DOCKER_INFLUXDB_INIT_ADMIN_TOKEN}

# Primary InfluxDB organization & bucket definitions
# 
DOCKER_INFLUXDB_INIT_ORG=${DOCKER_INFLUXDB_INIT_ORG}
DOCKER_INFLUXDB_INIT_BUCKET=${DOCKER_INFLUXDB_INIT_BUCKET}

# Primary InfluxDB bucket retention period
#
# NOTE: Valid units are nanoseconds (ns), microseconds(us), milliseconds (ms)
# seconds (s), minutes (m), hours (h), days (d), and weeks (w).
DOCKER_INFLUXDB_INIT_RETENTION=${DOCKER_INFLUXDB_INIT_RETENTION}


# InfluxDB port & hostname definitions
#
DOCKER_INFLUXDB_INIT_PORT=${DOCKER_INFLUXDB_INIT_PORT}
DOCKER_INFLUXDB_INIT_HOST=${DOCKER_INFLUXDB_INIT_HOST}

# Telegraf configuration file
# 
# Will be mounted to container and used as telegraf configuration
TELEGRAF_CFG_PATH=${TELEGRAF_CFG_PATH}

# Grafana port definition
GRAFANA_PORT=${GRAFANA_PORT}
