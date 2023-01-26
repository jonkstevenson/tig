output influxdb_pwd {
    value = "Password of InfluxDB admin account: ${nonsensitive(random_password.password.result)}
}