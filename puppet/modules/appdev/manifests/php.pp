class appdev::php($server_type='apache', $database_type='mysql'){

    package{'php5': ensure => present}
    package{'php5-cli': ensure => present, require => Package['php5'] }
    package{'php5-mcrypt': ensure => 'present',require => Package['php5']}
    package{'php5-gd': ensure => 'present', require => Package['php5'] }
    package{'php5-curl': ensure => 'present', require => Package['php5'] }

    if $server_type == 'apache' {
        #add the apache php5 module
        package{'libapache2-mod-php5':
                ensure=>'present', require => Package['php5']
        }
    }

    if $database_type == 'mysql' {
        package{'php5-mysql': ensure => 'present', require => Package['php5'] }
    }


}