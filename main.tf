module "system_config" {
  source = "./modules/system-config"

  system_update = var.system_update
  system_upgrade = var.system_upgrade
  install_git = var.install_git
  install_docker = var.install_docker
  install_docker_compose = var.install_docker_compose
  
}

module "docker_composer" {
  source = "./modules/docker-composer"
 
  DOCKER_INFLUXDB_INIT_MODE = var.DOCKER_INFLUXDB_INIT_MODE
  DOCKER_INFLUXDB_INIT_USERNAME = var.DOCKER_INFLUXDB_INIT_USERNAME
  DOCKER_INFLUXDB_INIT_PASSWORD = var.DOCKER_INFLUXDB_INIT_PASSWORD
  #DOCKER_INFLUXDB_HOSTNAME = var.DOCKER_INFLUXDB_HOSTNAME
  DOCKER_INFLUXDB_INIT_ADMIN_TOKEN = var.DOCKER_INFLUXDB_INIT_ADMIN_TOKEN
  DOCKER_INFLUXDB_INIT_ORG = var.DOCKER_INFLUXDB_INIT_ORG
  DOCKER_INFLUXDB_INIT_BUCKET = var.DOCKER_INFLUXDB_INIT_BUCKET
  DOCKER_INFLUXDB_INIT_RETENTION = var.DOCKER_INFLUXDB_INIT_RETENTION
  DOCKER_INFLUXDB_INIT_PORT = var.DOCKER_INFLUXDB_INIT_PORT
  DOCKER_INFLUXDB_INIT_HOST = var.DOCKER_INFLUXDB_INIT_HOST
  TELEGRAF_CFG_PATH = var.TELEGRAF_CFG_PATH
  GRAFANA_PORT= var.GRAFANA_PORT

}

