
node 'app' {
package { 'vim': ensure => present }
include sudo
include nrpe
}
node 'db' {
package { 'vim': ensure => present }
include sudo
include mysql
include nrpe
}
node 'storage' {
package { 'vim': ensure => present } 
include sudo
include nrpe
}
node 'mgmt' {
package { 'vim': ensure => present }
include sudo
include nagios
}

