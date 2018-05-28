class bacula-director::config {

file {"/etc/bacula/bacula-dir.conf":
ensure => present,
source => "puppet:///modules/bacula-director/etc/bacula/bacula-dir.conf",
mode => 664,
owner => "root",
group => "root",
require => Class["bacula-director::install"],
notify => Class ["bacula-director::service"],
}


file {"/etc/bacula/bconsole.conf":
ensure => present,
source => "puppet:///modules/bacula-director/etc/bacula/bconsole.conf",
mode => 664,
owner => "root",
group => "root",
require => Class["bacula-director::install"],
notify => Class ["bacula-director::service"],
}
}
