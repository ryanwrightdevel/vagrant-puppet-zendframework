define dotglob($command, $creates = ''){
     $the_command = $command
     $the_create = $creates
     file{"/tmp/dotglobon${name}":
          path => "/tmp/dotglobon.sh",
          content => template('dotglob/dotglobon.erb'),
          ensure => 'present'
     }
     if $the_creates != ''{
        exec{"run with create{name}":
            command => '/bin/bash /tmp/dotglobon.sh',
            creates => $the_create,
            require => File["/tmp/dotglobon${name}"]
        }
     }else{
        exec{"run without create{name}":
            command => '/bin/bash /tmp/dotglobon.sh',
            require => File["/tmp/dotglobon${name}"]
        }
     }
}