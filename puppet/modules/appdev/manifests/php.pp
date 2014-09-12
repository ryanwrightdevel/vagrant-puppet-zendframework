class appdev::php(
                  $server_type='apache',
                  $database_type='mysql',
                  $php_ini = '/etc/php5/apache2/php.ini'
                  ){

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

    exec{ 'add error log':
          command => "/bin/echo -e '#set log file\nerror_log = /var/www/log/php.log' >> ${php_ini}",
          require => Package['php5'],
          unless => "/bin/grep '#set log file' ${php_ini}"
    }


}