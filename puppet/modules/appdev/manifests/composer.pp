class appdev::composer{
  #include wget

  file{'/opt/composer':
        ensure => 'directory',
        owner => 'vagrant',
        group => 'vagrant'
  }


  wget::fetch { 'https://getcomposer.org/installer':
        destination => '/opt/composer/installer',
        timeout     => 10,
        verbose     => true,
        require => File['/opt/composer']
  }

  exec{'create composer.phar':
      command => 'php installer',
      cwd => '/opt/composer',
      require => Wget::Fetch['https://getcomposer.org/installer'],
      path => ['/usr/bin']
  }

  exec{'mv composer.phar':
    command => 'mv /opt/composer/composer.phar /usr/local/bin/composer',
    path => '/bin',
    require => Exec['create composer.phar']
  }

}