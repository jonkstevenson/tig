resource "null_resource" "update_system" {
  count    = var.system_update ? 1 : 0
  provisioner "local-exec" {
    command = "apt update -y"
  }

}

resource "null_resource" "upgrade_system" {
  count    = var.system_upgrade ? 1 : 0
  provisioner "local-exec" {
    command = "apt update -y"
  }

 provisioner "local-exec" {
    command = "apt upgrade -y"
  }

  depends_on = [
    null_resource.update_system
  ]

}

resource "null_resource" "install_git" {
  count    = var.install_git ? 1 : 0
  provisioner "local-exec" {
    command = "apt install git -y"
  }
  depends_on = [
    null_resource.update_system,
    null_resource.upgrade_system
  ]
}

resource "null_resource" "install_docker" {
  count    = var.install_docker ? 1 : 0

  provisioner "local-exec" {
    command = "./modules/system-config/scripts/install_docker.sh"
  }
  depends_on = [
    null_resource.update_system,
    null_resource.install_git,
    null_resource.upgrade_system
  ]
}

resource "null_resource" "install_docker_compose" {
  count    = var.install_docker_compose ? 1 : 0
  provisioner "local-exec" {
    command = "curl -L \"https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose"
  }
    provisioner "local-exec" {
    command = "chmod +x /usr/local/bin/docker-compose"
  }
  
  depends_on = [
    null_resource.update_system,
    null_resource.upgrade_system,
    null_resource.install_docker
  ]
}
