output influxdb_pwd {
    value = nonsensitive(random_password.password.result)
}