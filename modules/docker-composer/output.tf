output current_hostname {
    value = trimspace(data.local_file.hostname.content)
}