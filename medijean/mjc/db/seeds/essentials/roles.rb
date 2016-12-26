Role.find_or_create_by_name("doctor")
Role.find_or_create_by_name("nurse")
Role.find_or_create_by_name("patient")

Role.find_or_create_by_name_and_admin("sysadmin", true)
Role.find_or_create_by_name_and_admin("manager", true)
Role.find_or_create_by_name_and_admin("supervisor", true)
Role.find_or_create_by_name_and_admin("support", true)