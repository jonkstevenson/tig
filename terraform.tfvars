##  System Updates ##

system_update = true
system_upgrade = true
install_git = false
install_docker = true
install_docker_compose = true

DOCKER_INFLUXDB_INIT_MODE = "setup"
DOCKER_INFLUXDB_INIT_USERNAME = "admin"
DOCKER_INFLUXDB_INIT_ORG = "jon"
DOCKER_INFLUXDB_INIT_BUCKET = "telegraf"
DOCKER_INFLUXDB_INIT_RETENTION = "4d"
DOCKER_INFLUXDB_INIT_PORT = 8086
DOCKER_INFLUXDB_INIT_HOST = "influxdb"
TELEGRAF_CFG_PATH = "./telegraf/telegraf.conf"
GRAFANA_PORT = 3000


