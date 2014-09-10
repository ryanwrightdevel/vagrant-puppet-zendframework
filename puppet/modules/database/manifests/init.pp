class database($database_type='mysql',
                 $user = 'webdev',
                 $rootpassword = 'root',
                 $password = 'webdev',
                 $host = 'localhost',
                 $dbname='db'){

    if $database_type == 'mysql' {
        class { '::mysql::server':
            root_password    => "${rootpassword}"
        }
    }
}