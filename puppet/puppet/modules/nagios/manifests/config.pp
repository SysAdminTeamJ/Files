class nagios::config {

##################
#FILE DEFINITIONS#
##################

file { "/etc/nagios3/nagios.cfg":
ensure => present,
source => "puppet:///modules/nagios/etc/nagios3/nagios.cfg",
mode => 0444,
owner => "nagios",
group => "nagios",
require => Class["nagios::install"],
notify => Class["nagios::service"],
}
file { "/etc/nagios3/htpasswd.users":
ensure => present,
source => "puppet:///modules/nagios/etc/nagios3/htpasswd.users",
owner => "root",
group => "root",
mode => 0555,
require => Class["nagios::install"],
notify => Class["nagios::service"],
}
#####################
#CONTACT DEFINITIONS#
#####################

nagios_contact { 'scott':
target => '/etc/nagios3/conf.d/ppt_contacts.cfg',
alias => 'Scott McQueen',
service_notification_period => '24x7',
host_notification_period => '24x7',
service_notification_options => 'w,u,c,r',
host_notification_options => 'd,r',
service_notification_commands => 'notify-service-by-email, notify-service-by-slack',
host_notification_commands => 'notify-host-by-email, notify-host-by-slack',
email => 'mcquesd1@student.op.ac.nz',
}
nagios_contact { 'uddeshya':
target => '/etc/nagios3/conf.d/ppt_contacts.cfg',
alias => 'Uddeshya Sinha',
service_notification_period => '24x7',
host_notification_period => '24x7',
service_notification_options => 'w,u,c,r',
host_notification_options => 'd,r',
service_notification_commands => 'notify-service-by-email',
host_notification_commands => 'notify-host-by-email',
email => 'sinhauddeshya@gmail.com',
}
nagios_contactgroup { 'sysadmins':
target => '/etc/nagios3/conf.d/ppt_contactgroups.cfg',
alias => 'Systems Administrators',
members => 'uddeshya, scott'
}
###################
#HOSTS DEFINITIONS#
###################

nagios_host { 'storage.foo.org.nz':
target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
alias => 'storage',
address => '10.25.137.165',
check_period => '24x7',
max_check_attempts => 3,
check_command => 'check-host-alive',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'd,u,r',
contact_groups => 'sysadmins',
}
nagios_host { 'db.foo.org.nz':
target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
alias => 'db',
address => '10.25.100.26',
check_period => '24x7',
max_check_attempts => 3,
check_command => 'check-host-alive',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'd,u,r',
contact_groups => 'sysadmins',
}
nagios_host { 'app.foo.org.nz':
target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
alias => 'app',
address => '10.25.137.161',
check_period => '24x7',
max_check_attempts => 3,
check_command => 'check-host-alive',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'd,u,r',
contact_groups => 'sysadmins',
}
nagios_host { 'ad.directory.foo.org.nz':
target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
alias => 'ad',
address => '10.25.137.130',
check_period => '24x7',
max_check_attempts => 3,
check_command => 'check-host-alive',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'd,u,r',
contact_groups => 'sysadmins',
}
nagios_host { 'localhost':
target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
alias => 'mgmt',
address => '127.0.0.1',
check_period => '24x7',
max_check_attempts => 3,
check_command => 'check-host-alive',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'd,u,r',
contact_groups => 'sysadmins',
}


#####################
#SERVICE DEFINITIONS#
#####################

nagios_service {'MySQL':
service_description => 'MySQL DB',
hostgroup_name => 'db-servers',
target => '/etc/nagios3/conf.d/ppt_mysql_service.cfg',
check_command => 'check_mysql_cmdlinecred!$USER3$!$USER4$',
max_check_attempts => 3,
retry_check_interval => 1,
normal_check_interval => 5,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',
}

nagios_service {'HTTP_Server':
service_description => 'HTTP Server',
hostgroup_name => 'http-servers',
target => '/etc/nagios3/conf.d/ppt_services.cfg',
check_command => 'check_http',
max_check_attempts => 3,
retry_check_interval => 1,
normal_check_interval => 2,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',
}

nagios_service {'Http_Server_URL':
service_description => 'HTTP Server URL',
host_name => 'app.foo.org.nz',
target => '/etc/nagios3/conf.d/ppt_services.cfg',
check_command => 'HTTP_URL',
max_check_attempts => 3,
retry_check_interval => 1,
normal_check_interval => 2,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',

}

nagios_service {'Http_Server_String':
service_description => 'HTTP Server String',
host_name => 'app.foo.org.nz',
target => '/etc/nagios3/conf.d/ppt_services.cfg',
check_command => 'HTTP_STRING',
max_check_attempts => 3,
retry_check_interval => 1,
normal_check_interval => 2,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',
}

nagios_service {'SSH_Server':
service_description => 'SSH Server',
hostgroup_name => 'ssh-servers',
target => '/etc/nagios3/conf.d/ppt_services.cfg',
check_command => 'check_ssh',
max_check_attempts => 3,
retry_check_interval => 1,
normal_check_interval => 2,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',
}

nagios_service {'Disk_Check':
service_description => 'Disk Space',
host_name => 'localhost',
target => '/etc/nagios3/conf.d/ppt_localhost.cfg',
check_command => 'check_all_disks!20%!10%',
max_check_attempts => 3,
retry_check_interval => 1,
normal_check_interval => 2,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',
}

nagios_service {'Current_Users':
service_description => 'Current Users',
host_name => 'localhost',
target => '/etc/nagios3/conf.d/ppt_localhost.cfg',
check_command => 'check_users!20!50',
max_check_attempts => 3,
retry_check_interval => 1,
normal_check_interval => 2,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',
}

nagios_service {'Total_Processes':
service_description => 'Total Processes',
host_name => 'localhost',
target => '/etc/nagios3/conf.d/ppt_localhost.cfg',
check_command => 'check_procs!250!400',
max_check_attempts => 3,
retry_check_interval => 1,
normal_check_interval => 2,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',
}

nagios_service {'Current_Load':
service_description => 'Current Load',
host_name => 'localhost',
target => '/etc/nagios3/conf.d/ppt_localhost.cfg',
check_command => 'check_load!5.0!4.0!3.0!10.0!6.0!4.0',
max_check_attempts => 3,
retry_check_interval => 1,
normal_check_interval => 2,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',
}
nagios_service {'Shiver me Timbers':
service_description => 'Shiver Me Timbers',
host_name => 'localhost',
target => '/etc/nagios3/conf.d/ppt_localhost.cfg',
check_command => 'shiver_me_timbers',
max_check_attempts => 2,
retry_check_interval => 1,
normal_check_interval => 1,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',
}

nagios_service {'NRPE_CheckDisk':
service_description => 'Disk Space',
hostgroup_name => 'remote-disks',
target => '/etc/nagios3/conf.d/ppt_remote_disks.cfg',
check_command => 'check_nrpe_1arg!check_hd',
max_check_attempts => 3,
retry_check_interval => 1,
normal_check_interval => 2,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',
}

nagios_service {'NRPE_Check_Users':
service_description => 'Current Users',
hostgroup_name => 'remote-disks',
target => '/etc/nagios3/conf.d/ppt_remote_disks.cfg',
check_command => 'check_nrpe_1arg!check_users',
max_check_attempts => 3,
retry_check_interval => 1,
normal_check_interval => 2,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',
}

nagios_service {'NRPE_Check_Load':
service_description => 'Current Load',
hostgroup_name => 'remote-disks',
target => '/etc/nagios3/conf.d/ppt_remote_disks.cfg',
check_command => 'check_nrpe_1arg!check_load',
max_check_attempts => 3,
retry_check_interval => 1,
normal_check_interval => 2,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',
}

nagios_service {'NRPE_Check_Zombie_Procs':
service_description => 'Zombie Processes',
hostgroup_name => 'remote-disks',
target => '/etc/nagios3/conf.d/ppt_remote_disks.cfg',
check_command => 'check_nrpe_1arg!check_zombie_procs',
max_check_attempts => 3,
retry_check_interval => 1,
normal_check_interval => 2,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',
}

nagios_service {'NRPE_Check_Total_Procs':
service_description => 'Total Processes',
hostgroup_name => 'remote-disks',
target => '/etc/nagios3/conf.d/ppt_remote_disks.cfg',
check_command => 'check_nrpe_1arg!check_total_procs',
max_check_attempts => 3,
retry_check_interval => 1,
normal_check_interval => 2,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',
}
nagios_service {'NRPE_Shiver_Me_Timbers':
service_description => 'Shiver Me Timbers',
hostgroup_name => 'remote-disks',
target => '/etc/nagios3/conf.d/ppt_remote_disks.cfg',
check_command => 'check_nrpe_1arg!Shiver_me_timbers',
max_check_attempts => 2,
retry_check_interval => 1,
normal_check_interval => 1,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',
}

nagios_service {'Windows_MEMUSE':
service_description => 'Memory Use',
hostgroup_name => 'windows-servers',
target => '/etc/nagios3/conf.d/ppt_windows.cfg',
check_command => 'my_check_nt_mem!MEMUSE!90!95',
max_check_attempts => 3,
retry_check_interval => 1,
normal_check_interval => 2,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',
}

nagios_service {'Windows_CPULOAD':
service_description => 'CPU Load',
hostgroup_name => 'windows-servers',
target => '/etc/nagios3/conf.d/ppt_windows.cfg',
check_command => 'my_check_nt!CPULOAD!10,80,90',
max_check_attempts => 3,
retry_check_interval => 1,
normal_check_interval => 2,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',
}

nagios_service {'Windows_USEDDISKSPACE':
service_description => 'Disk Space',
hostgroup_name => 'windows-servers',
target => '/etc/nagios3/conf.d/ppt_windows.cfg',
check_command => 'my_check_nt!USEDDISKSPACE!C!90!95',
max_check_attempts => 3,
retry_check_interval => 1,
normal_check_interval => 2,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',
}

nagios_service {'Windows_UPTIME':
service_description => 'Up Time',
hostgroup_name => 'windows-servers',
target => '/etc/nagios3/conf.d/ppt_windows.cfg',
check_command => 'my_check_nt!UPTIME',
max_check_attempts => 3,
retry_check_interval => 1,
normal_check_interval => 2,
check_period => '24x7',
notification_interval => 30,
notification_period => '24x7',
notification_options => 'w,u,c',
contact_groups => 'sysadmins',
}


########################
#HOSTGROUPS DEFINITIONS#
########################

nagios_hostgroup{'db-servers':
target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
alias => 'Database Servers',
members => 'db.foo.org.nz',
}
nagios_hostgroup{'remote-disks':
target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
alias => 'Remote Disks NRPE',
members => 'db.foo.org.nz, storage.foo.org.nz, app.foo.org.nz',
}
nagios_hostgroup{'windows-servers':
target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
alias => 'Windows Servers',
members => 'ad.directory.foo.org.nz',
}
nagios_hostgroup{'ubuntu-linux':
target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
alias => 'Ubuntu Linux Servers',
members => 'localhost, db.foo.org.nz, storage.foo.org.nz, app.foo.org.nz',
}
nagios_hostgroup{'http-servers':
target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
alias => 'HTTP Servers',
members => 'localhost, app.foo.org.nz',
}
nagios_hostgroup{'ssh-servers':
target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
alias => 'SSH Servers',
members => 'localhost, db.foo.org.nz, storage.foo.org.nz, app.foo.org.nz',
}


}
