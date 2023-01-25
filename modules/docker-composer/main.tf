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


}

resource "local_file" "create_telegraf_config" { 
    content = data.template_file.init_telegraf_config.rendered
    filename = "./install_tig/telegraf/telegraf.conf"

}