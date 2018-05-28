
node 'app' {
package { 'vim': ensure => present }
include sudo
include nrpe
include bacula-file
}
node 'db' {
package { 'vim': ensure => present }
include sudo
include mysql
include nrpe
include bacula-file
}
node 'storage' {
package { 'vim': ensure => present } 
include sudo
include nrpe
include bacula-storage
include bacula-file
include bacula-director
}
node 'mgmt' {
package { 'vim': ensure => present }
include sudo
include nagios
include bacula-file
}

