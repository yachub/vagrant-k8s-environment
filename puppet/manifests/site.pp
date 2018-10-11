create_resources(host, lookup('hosts'), lookup('hostdefaults'))

include Class['kubernetes']
