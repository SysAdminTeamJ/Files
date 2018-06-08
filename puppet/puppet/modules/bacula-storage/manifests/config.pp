class bacula-storage::config {
file { "/etc/bacula/bacula-sd.conf":
ensure => present,
source => "puppet:///modules/bacula-storage/etc/bacula/bacula-sd.conf",
mode => 664,
owner => "root",
group => "root",
require => Class["bacula-storage::install"],
notify => Class["bacula-storage::service"],
}
}
