data "template_file" "init_compose_env" {
  template = "${file("./templates/template_env.tpl")}"
  vars = {
    DOCKER_INFLUXDB_INIT_MODE = var.DOCKER_INFLUXDB_INIT_MODE
    DOCKER_INFLUXDB_INIT_USERNAME = var.DOCKER_INFLUXDB_INIT_USERNAME
    DOCKER_INFLUXDB_INIT_PASSWORD = var.DOCKER_INFLUXDB_INIT_PASSWORD
    #DOCKER_INFLUXDB_INIT_ADMIN_TOKEN = var.DOCKER_INFLUXDB_INIT_ADMIN_TOKEN
    DOCKER_INFLUXDB_INIT_ORG = var.DOCKER_INFLUXDB_INIT_ORG
    DOCKER_INFLUXDB_INIT_BUCKET = var.DOCKER_INFLUXDB_INIT_BUCKET
    DOCKER_INFLUXDB_INIT_RETENTION = var.DOCKER_INFLUXDB_INIT_RETENTION
    DOCKER_INFLUXDB_INIT_PORT = var.DOCKER_INFLUXDB_INIT_PORT
    DOCKER_INFLUXDB_INIT_HOST = var.DOCKER_INFLUXDB_INIT_HOST
    TELEGRAF_CFG_PATH = var.TELEGRAF_CFG_PATH
    GRAFANA_PORT = var.GRAFANA_PORT

  }

}

data "template_file" "init_telegraf_config" {
  template = "${file("./templates/telegraf_conf.tpl")}"
  vars = {
    #DOCKER_INFLUXDB_HOSTNAME = var.DOCKER_INFLUXDB_HOSTNAME
    DOCKER_INFLUXDB_INIT_PORT = var.DOCKER_INFLUXDB_INIT_PORT
    #DOCKER_INFLUXDB_INIT_ADMIN_TOKEN = var.DOCKER_INFLUXDB_INIT_ADMIN_TOKEN
    DOCKER_INFLUXDB_INIT_ORG = var.DOCKER_INFLUXDB_INIT_ORG
    DOCKER_INFLUXDB_INIT_BUCKET = var.DOCKER_INFLUXDB_INIT_BUCKET
  }

}

data "template_file" "init_influxdb_config" {
  template = "${file("./templates/influxdb_datasource.tpl")}"
  vars = {
    HOSTNAME = trimspace(data.local_file.hostname.content)
    DOCKER_INFLUXDB_INIT_PORT = var.DOCKER_INFLUXDB_INIT_PORT
    DOCKER_INFLUXDB_INIT_ADMIN_TOKEN = trimspace(data.local_file.influx_token_key.content)
    DOCKER_INFLUXDB_INIT_ORG = var.DOCKER_INFLUXDB_INIT_ORG
    DOCKER_INFLUXDB_INIT_BUCKET = var.DOCKER_INFLUXDB_INIT_BUCKET
  }

}

data "local_file" "influx_token_key" {
    filename = "./install_tig/token.key"

 depends_on = [
   null_resource.generate_random_key
 ]
}

data "local_file" "hostname" {
    filename = "./install_tig/hostname"
    
 depends_on = [
   null_resource.get_hostname
 ]
}