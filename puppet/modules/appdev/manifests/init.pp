

class appdev($server_type='apache',
             $database_type='mysql',
             $web_root = '/var/www/html'){

    #Install some basic programs such as GIT, VIM
    #Update the apt-get respository
    include appdev::essentials

    #install composer
    include appdev::composer

    #install the apache webserver
    #only apache is supported at the moment
    if $server_type == 'apache' {
        class {'appdev::apache':
               web_root => $web_root,
               require => Class['appdev::essentials']
        }
    }

    class {"database":
            database_type => $database_type,
            require=> Class['appdev::essentials']
    }

    #install php
    class {'appdev::php':
        #only apache is supported at the moment
        server_type => 'apache',
        database_type => 'mysql',
        require => Class['appdev::essentials'],
        notify => Service['apache2']
    }



}