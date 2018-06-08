class bacula-file::config {
file { "/etc/bacula/bacula-fd.conf":
ensure => present,
content => template('bacula-file/filedaemon.erb'),
mode => 664,
owner => "root",
group => "root",
require => Class["bacula-file::install"],
notify => Class["bacula-file::service"]
}
}
