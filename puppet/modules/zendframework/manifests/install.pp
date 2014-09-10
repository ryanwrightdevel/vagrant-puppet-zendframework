class zendframework::install($installpath='/var/www/html'){
     $tmp_dir = '/home/vagrant/zf2'

     #download zend
     exec{'git-zend':
         command => "/usr/bin/git clone https://github.com/zendframework/ZendSkeletonApplication ${installpath} 2>&1 | cat",
         require => Class['appdev'],
         logoutput => true
     }

     exec{'composer-self-update':
          environment => [ "COMPOSER_HOME=/" ],
          command => '/usr/local/bin/composer install',
          # path => '/usr/bin/',
          cwd => $installpath,
          require => [ Exec['git-zend'] ]
     }
     exec{'composer-install-dependencies':
          environment => [ "COMPOSER_HOME=/" ],
          command => '/usr/bin/php composer.phar self-update',
          cwd => $installpath,
          require => Exec['composer-self-update']
     }

}