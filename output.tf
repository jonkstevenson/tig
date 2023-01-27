
output influxdb_url {
    value ="Influxdb URL: http://${module.docker_composer.current_hostname}:${var.DOCKER_INFLUXDB_INIT_PORT}"
}

output influxdb_user {
    value = "Influxdb User: ${var.DOCKER_INFLUXDB_INIT_USERNAME}"

}

output influxdb_pwd {
    value = "Influxdb Password:  ${nonsensitive(random_password.password.result)}"
}

output grafana_url {
    value ="Grafana URL: http://${module.docker_composer.current_hostname}:${var.GRAFANA_PORT}"
}

output grafana_user {
    value = "Grafana User: admin "
}

output grafana_pwd {
    value = "Grafana Password:  ${nonsensitive(random_password.password.result)}"
}