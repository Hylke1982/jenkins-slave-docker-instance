class { 'apt':
  always_apt_update    => true,
  update_timeout       => undef,
  purge_sources_list   => true
}

class devopsmachine::installation {
  class { 'devopsmachine::installation::debs' : } ->
  class { 'devopsmachine::installation::packages' : } ->
  class { 'devopsmachine::installation::jenkinsslave': } ->
  class { 'devopsmachine::installation::dockersettings': } ->
  class { 'devopsmachine::installation::dockerimages': } ->
  class { 'devopsmachine::installation::adddockerusers': }
}

class devopsmachine::installation::debs {


  apt::source { 'deb':
    location    => 'http://nl.archive.ubuntu.com/ubuntu/',
    release     => "trusty",
    repos       => 'main restricted universe multiverse',
    include_src => true
  }
  apt::source { 'deb-updates':
    location    => 'http://nl.archive.ubuntu.com/ubuntu/',
    release     => "trusty-updates",
    repos       => 'main restricted universe multiverse',
    include_src => true
  }
  apt::source { 'deb-security':
    location    => 'http://nl.archive.ubuntu.com/ubuntu/',
    release     => "trusty-security",
    repos       => 'main',
    include_src => true
  }

  apt::source { 'jenkins':
    location    => 'http://pkg.jenkins-ci.org/debian',
    release     => 'binary/',
    repos       => '',
    key         => 'D50582E6',
    key_source  => 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key',
    include_src => false,
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
    labels                => "docker puppet node",
    masterurl             => 'http://33.33.33.30:8080',
    slave_user            => 'jenkins',
    install_java          => false,
  }
}

class devopsmachine::installation::dockersettings{
  class { 'docker':
    manage_kernel  => false,
    dns            => '8.8.8.8',
  }
}

class devopsmachine::installation::dockerimages{
# Puppet test container
  docker::image { 'puppet-test':
    docker_file => '/vagrant/files/puppet-test-container.dockerfile'
  }
# NodeJS test base container
  docker::image { 'nodejs-test':
    docker_file => '/vagrant/files/nodejs-test-container.dockerfile'
  } ->
  # Karma NodeJS test container
  docker::image { 'jasmine-nodejs-test':
    docker_file => '/vagrant/files/jasmine-test-container.dockerfile'
  }
}

class devopsmachine::installation::adddockerusers{
  group { 'docker' :
    members => ['jenkins']
  }
}

node default{

  class { 'devopsmachine::installation': }

}