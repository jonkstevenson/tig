
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
  description = "install docker on the system .. required if using the docker runtime"
  type        = bool
  default     = false
}