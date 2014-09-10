class database::create($database_type='mysql',
                       $user = 'webdev',
                       $password = 'webdev',
                       $host = 'localhost',
                       $dbname='db',
                       $grant = ['ALL']
                       ){
   if $database_type == 'mysql' {
         mysql::db { "${dbname}" :
              user     => $user,
              password => $password,
              host     => $host,
              grant    => $grant,
              require => Class['::mysql::server']
        }
    }
}