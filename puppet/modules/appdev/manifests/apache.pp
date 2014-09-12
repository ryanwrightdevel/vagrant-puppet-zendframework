class appdev::apache($web_root = '/var/www/html',
                     $apache_error_log = '/vagrant/log/apache_error.log',
                     $apache_access_log = '/vagrant/log/apache_access.log'
                    ){
    #class {'apache':
    #}
    #apache::mod { 'rewrite': }

    $vhost_filename = '000-default.conf'

    exec{'install apache2':
        command => '/usr/bin/apt-get -y install apache2',

    }

    exec{'enabled mod-rewrite':
        command => '/usr/sbin/a2enmod rewrite',
        require => Exec['install apache2']
    }

    file{'remove apache index.html':
       ensure => absent,
       path => '/var/www/html/index.html',
       require => Exec['install apache2']
    }
    file{'remove html readme':
       ensure => absent,
       path => '/var/www/html/whatisthis-readme',
       require => Exec['install apache2']
    }

    #exec{'change-web-root':
    #     command => 'sed -i "s/\/var\/www/\/var\/www\/html/g" /etc/apache2/sites-available/000-default.conf',
    #     path => '/bin/',
    #     require => [Exec['install apache2'], File['remove apache index.html']]
    #     #require => Service['httpd']
    #}
    #exec{'override':
    #     command => 'sed -i "s/AllowOverride None/AllowOverride ALL/g" /etc/apache2/sites-available/000-default.conf',
    #     path => '/bin/',
    #     require => Exec['enabled mod-rewrite']
   #}

   file{"replacing-vhost-file":
             path => "/etc/apache2/sites-available/${vhost_filename}",
             content => template('appdev/vhost.erb'),
             ensure => present,
             require => Exec["enabled mod-rewrite"]

   }

   service{'apache2':
         ensure => "running",
         require => Exec['install apache2']
   }
}
