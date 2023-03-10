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

}

variable "DOCKER_INFLUXDB_INIT_PASSWORD" {
  description = "DOCKER_INFLUXDB_INIT_PASSWORD"
  type        = string

}

#variable "DOCKER_INFLUXDB_INIT_ADMIN_TOKEN" {
#  description = "DOCKER_INFLUXDB_INIT_ADMIN_TOKEN"
 # type        = string
 # default     = "39477970d8cb52692dcfc689f1a2614ac074ca94e5e231489fbcaa00ccac7763"
#}

# Primary InfluxDB organization & bucket definitions FLUX
#
#variable "DOCKER_INFLUXDB_HOSTNAME" {
#  description = "URL for influx db"
#  type        = string
 # default     = "ec2-35-80-237-168.us-west-2.compute.amazonaws.com"
#}

variable "DOCKER_INFLUXDB_INIT_ORG" {
  description = "DOCKER_INFLUXDB_INIT_ORG"
  type        = string

}
variable "DOCKER_INFLUXDB_INIT_BUCKET" {
  description = "DOCKER_INFLUXDB_INIT_BUCKET"
  type        = string

}

# Primary InfluxDB bucket retention period
#
# NOTE: Valid units are nanoseconds (ns), microseconds(us), milliseconds (ms)
# seconds (s), minutes (m), hours (h), days (d), and weeks (w).
variable "DOCKER_INFLUXDB_INIT_RETENTION" {
  description = "DOCKER_INFLUXDB_INIT_RETENTION"
  type        = string

}

# InfluxDB port & hostname definitions
#
variable "DOCKER_INFLUXDB_INIT_PORT" {
  description = "DOCKER_INFLUXDB_INIT_PORT"
  type        = number

}
variable "DOCKER_INFLUXDB_INIT_HOST" {
  description = "DOCKER_INFLUXDB_INIT_HOST"
  type        = string

}

# Telegraf configuration file
#
# Will be mounted to container and used as telegraf configuration
variable "TELEGRAF_CFG_PATH" {
  description = "TELEGRAF_CFG_PATH"
  type        = string

}

# Grafana port definition
variable "GRAFANA_PORT" {
  description = "GRAFANA_PORT"
  type = number

}

