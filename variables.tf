
#### system update variables #####
###

#run update packages and software

variable "system_update" {
  description = "update the system to the latest"
  type        = bool
  default     = false
}

variable "system_upgrade" {
  description = "upgrade the system to the latest"
  type        = bool
  default     = false
}

variable "install_git" {
  description = "install git on the system .. required to clone repository"
  type        = bool
  default     = false
}

variable "install_docker" {
  description = "install docker on the system .. required if using the docker runtime"
  type        = bool
  default     = false
}

variable "install_docker_compose" {
  description = "install docker-compose required for deployment on docker"
  type        = bool
  default     = false
}

## Environment variables used during the setup and operation of the stack
## for docker composer

variable "DOCKER_INFLUXDB_INIT_MODE" {
  description = "docker influxdb init mode"
  type        = string
  default     = "setup"
}

# Primary InfluxDB admin/superuser credentials
#

variable "DOCKER_INFLUXDB_INIT_USERNAME" {
  description = "DOCKER_INFLUXDB_INIT_USERNAME"
  type        = string
  default     = "jon"
}

variable "DOCKER_INFLUXDB_INIT_PASSWORD" {
  description = "DOCKER_INFLUXDB_INIT_PASSWORD"
  type        = string
  default     = "adminpwd"
}


variable "DOCKER_INFLUXDB_INIT_ORG" {
  description = "DOCKER_INFLUXDB_INIT_ORG"
  type        = string
  default     = "jon"
}
variable "DOCKER_INFLUXDB_INIT_BUCKET" {
  description = "DOCKER_INFLUXDB_INIT_BUCKET"
  type        = string
  default     = "telegraf"
}

# Primary InfluxDB bucket retention period
#
# NOTE: Valid units are nanoseconds (ns), microseconds(us), milliseconds (ms)
# seconds (s), minutes (m), hours (h), days (d), and weeks (w).
variable "DOCKER_INFLUXDB_INIT_RETENTION" {
  description = "DOCKER_INFLUXDB_INIT_RETENTION"
  type        = string
  default     = "4d"
}

# InfluxDB port & hostname definitions
#
variable "DOCKER_INFLUXDB_INIT_PORT" {
  description = "DOCKER_INFLUXDB_INIT_PORT"
  type        = number
  default     = 8086
}
variable "DOCKER_INFLUXDB_INIT_HOST" {
  description = "DOCKER_INFLUXDB_INIT_HOST"
  type        = string
  default     = "influxdb"
}

# Telegraf configuration file
#
# Will be mounted to container and used as telegraf configuration
variable "TELEGRAF_CFG_PATH" {
  description = "TELEGRAF_CFG_PATH"
  type        = string
  default     = "./telegraf/telegraf.conf"
}

# Grafana port definition
variable "GRAFANA_PORT" {
  description = "GRAFANA_PORT"
  type = number
  default     = 3000
}






