
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

output notes {
    value = "NOTE: the URL will be private address you may need to use public accessible names if using AWS/Azure/GCP"
}

output sg_notes {
    value = "NOTE: if using a cloud provider ensure ports ${var.GRAFANA_PORT} and ${var.DOCKER_INFLUXDB_INIT_PORT} are available to access the remote sites"
}