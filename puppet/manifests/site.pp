#include stdlib  #stdlib module required by apt module
#include apt     #needed to resolve 'Invalid Resource Type' error in mysql module

class preserver{
    #install mysql server using default setting
    exec{ 'apt-get update':
      command => '/usr/bin/apt-get update'
    }
    package{'vim':
        require => Exec['apt-get update']
    }
    package{'git':
        require => Exec['apt-get update']
    }

}
stage{'pre':
    before => Stage['main']
}

class {'preserver':
    stage => 'pre'
}

class { '::mysql::server':
    root_password    => 'root'
}

class {'apache':
}

package{'php5': ensure => present, require => Class['apache']}

package{'php5-cli': ensure => present, require => Package['php5']}

package{'libapache2-mod-php5': ensure=>'present',require=>Package['php5']}
package{'php5-mcrypt': ensure=>'present',require=>Package['php5']}
package{'libapache2-mod-auth-mysql': ensure=>'present',require=>Package['php5']}
package{'php5-mysql': ensure=>'present', require=>Class['::mysql::server']}
package{'php5-gd': ensure=>'present', require=>Package['php5']}
package{'php5-curl': ensure=>'present', require=>Package['php5']}

 mysql::db { 'drupal':
      user     => 'web',
      password => 'web',
      host     => 'localhost',
      grant    => ['ALL'],
      require => Class['::mysql::server']
}



class { 'composer':
  command_name => 'composer',
  target_dir   => '/usr/local/bin'
}

class zend{
   #download zend
   exec{'git-zend':
       command => 'git clone https://github.com/zendframework/ZendSkeletonApplication /var/www/html',
       path => '/usr/bin/',
       require => Package['git']
   }
   exec{'composer-self-update':
        command => 'php composer.phar self-update',
        path => '/usr/bin/',
        cwd => '/var/www/html',
        require => Exec['git-zend']
   }
   exec{'composer-install-dependencies':
        command => 'php composer.phar install',
        path => '/usr/bin/',
        cwd => '/var/www/html',
        require => Exec['composer-self-update']
   }
   exec{'change-web-root':
        command => 'sed -i "s/\/var\/www/\/var\/www\/html\/public/g" /etc/apache2/sites-available/15-default.conf',
        path => '/bin/',
        require => Exec['composer-install-dependencies'] ,
        notify => Service['httpd']
   }
}



class{'zend':
    require => Package['php5']
}
