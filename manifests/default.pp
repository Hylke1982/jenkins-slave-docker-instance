class { 'apt':
  always_apt_update    => true,
  update_timeout       => undef,
  purge_sources_list   => true
}

class devopsmachine::installation {
  class { 'devopsmachine::installation::packages' : } ->
  class { 'devopsmachine::installation::jenkinsslave': } ->
  class { 'devopsmachine::installation::dockersettings': } ->
  class { 'devopsmachine::installation::dockerimages': }
}

class devopsmachine::installation::debs {

  apt::source { 'deb':
    location          => 'http://ftp.nl.debian.org/debian/',
    release           => "jessie",
    repos             => 'main',
    include_src       => true
  }

  apt::source { 'deb-updates':
    location          => 'http://ftp.nl.debian.org/debian/',
    release           => "jessie-updates",
    repos             => 'main',
    include_src       => true
  }

  apt::source { 'deb-security':
    location          => 'http://ftp.nl.debian.org/debian-security/',
    release           => "jessie/updates",
    repos             => 'main',
    include_src       => true
  }

}

class devopsmachine::installation::packages{
  package { ["maven","openjdk-7-jdk","debian-keyring","debian-archive-keyring"]:
    ensure => "present"
  }

}

class devopsmachine::installation::jenkinsslave{
  class { 'jenkins::slave':
    slave_name            => "docker-slave",
    labels                => "docker",
    masterurl             => 'http://33.33.33.30:8080',
    install_java          => false,
  }
}

class devopsmachine::installation::dockersettings{
  class { 'docker':
    version => 'latest',
    dns     => '8.8.8.8',
  }
}

class devopsmachine::installation::dockerimages{
  docker::image { 'puppet-test':
    docker_file => '/vagrant/files/puppet-test-container.dockerfile'
  }
}

node default{

  class { 'devopsmachine::installation': }

}