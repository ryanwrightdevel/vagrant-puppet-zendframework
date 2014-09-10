class zendframework{

   class {"appdev":
           #type of server we'd like to use
           server_type => 'apache',
           #type of database we'd like to use
           database_type => 'mysql',
           #set the webroot for zend
           web_root => '/var/www/html/public'
   }

   class {"zendframework::install":
          require => [ Class['appdev'], Class['appdev::essentials'], Class['appdev::composer']]
   }

}