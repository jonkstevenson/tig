resource "null_resource" "create_tmp_directory_for_install" {
  provisioner "local-exec" {
    when = create
    command = "mkdir ./install_tig"
  }
  provisioner "local-exec" {
    when = destroy
    command = "rm -rf ./install_tig"
  }

}

resource "null_resource" "cp_docker_composer_source" {
  provisioner "local-exec" {
    when = create
    command = "cp -pr ./helm/* ./install_tig"
  }
  depends_on = [
    null_resource.create_tmp_directory_for_install
  ]
}

resource "local_file" "create_composer_environment" { 
    content = data.template_file.init_compose_env.rendered
    filename = "./install_tig/.env"

  depends_on = [
    null_resource.cp_docker_composer_source
  ]
}

resource "local_file" "create_telegraf_config" { 
    content = data.template_file.init_telegraf_config.rendered
    filename = "./install_tig/telegraf/telegraf.conf"
  
  depends_on = [
    null_resource.cp_docker_composer_source
  ]
}

resource "null_resource" "update_telegraf_hostname" {
  provisioner "local-exec" {
    when = create
    command = "sed -i s/DOCKER_INFLUXDB_HOSTNAME/`hostname`/g ./install_tig/telegraf/telegraf.conf"
  }
  depends_on = [
    local_file.create_telegraf_config,
    local_file.create_composer_environment

  ]
}

resource "null_resource" "generate_random_key" {
  provisioner "local-exec" {
    when = create
    command = "openssl rand -hex 32 > ./install_tig/token.key"
  }
  depends_on = [
    null_resource.update_telegraf_hostname
  ]
}

resource "null_resource" "get_hostname" {
  provisioner "local-exec" {
    when = create
    command = "hostname > ./install_tig/hostname"
  }
  depends_on = [
    null_resource.update_telegraf_hostname
  ]
}


resource "null_resource" "update_telegraf_token" {
  provisioner "local-exec" {
    when = create
    command = "sed -i s/DOCKER_INFLUXDB_INIT_ADMIN_TOKEN/${trimspace(data.local_file.influx_token_key.content)}/g ./install_tig/telegraf/telegraf.conf"
  }
  depends_on = [
    null_resource.generate_random_key

  ]
}

resource "null_resource" "update_environment_token" {
  provisioner "local-exec" {
    when = create
    command = "sed -i s/docker_influxdb_init_admin_token/${trimspace(data.local_file.influx_token_key.content)}/g ./install_tig/.env"
  }
  depends_on = [
    null_resource.update_telegraf_token

  ]
}


resource "null_resource" "update_default_telegraf_config" {
  provisioner "local-exec" {
    when = create
    command = "cp ./install_tig/telegraf/telegraf.conf /etc/telegraf/telegraf.conf"
  }
  depends_on = [
    null_resource.update_environment_token

  ]
}

resource "null_resource" "give_telegraf_access_to_docker" {
  provisioner "local-exec" {
    when = create
    command = "usermod -a -G docker _telegraf"
  }
  depends_on = [
    null_resource.update_default_telegraf_config

  ]
}

resource "null_resource" "restart_local_telegraf" {
  provisioner "local-exec" {
    when = create
    command = "systemctl daemon-reload && systemctl enable telegraf && systemctl restart telegraf"
  }
  depends_on = [
    null_resource.give_telegraf_access_to_docker

  ]
}



resource "null_resource" "docker_composer_install_tig" {
  provisioner "local-exec" {
    when = create
    command = "cd ./install_tig && docker-compose up -d"
  }
  provisioner "local-exec" {
    when = destroy
    command = "cd ./install_tig && docker-compose down"
  }
  depends_on = [
    null_resource.update_environment_token

  ]
}


resource "null_resource" "update_grafana_password" {
  provisioner "local-exec" {
    when = create
    command = "sleep 30 && docker exec install_tig_grafana_1 grafana-cli admin reset-admin-password ${var.DOCKER_INFLUXDB_INIT_PASSWORD}"
  }

  depends_on = [
    null_resource.docker_composer_install_tig

  ]
}

