
class appdev::essentials{
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
    package{'curl':
        require => Exec['apt-get update']
    }
    package{'unzip':
        require => Exec['apt-get update']
    }

}