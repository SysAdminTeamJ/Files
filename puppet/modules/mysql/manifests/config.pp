class mysql::config {
file { "/etc/mysql/mysql.cnf":
ensure => present,
source => "puppet:///modules/mysql/mysql.cnf",
mode => 0444,
owner => "mysql",
group => "mysql",
require => Class["mysql::install"],
notify => Class["mysql::service"],
}
file { "/etc/mysql/debian-start":
ensure => present,
source => "puppet:///modules/mysql/debian-start",
owner => "root",
group => "root",
mode => 0555,
require => Class["mysql::install"],
notify => Class["mysql::service"],
}
}
