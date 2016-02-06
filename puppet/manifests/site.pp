exec{ "apt-update":
  command => '/usr/bin/apt-get update'
}
#make sure to run apt-get update before installing any packages.
Exec['apt-update'] -> Package <| |>

class{'zendframework':
}