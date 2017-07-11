# set up the service
# @param username username of the bamboo-agent service account
# @param home home directory of the bamboo-agent user
define bamboo_agent::service ( $service_name, $agent_home ){
  assert_private()

  $username  = getparam(Bamboo_agent::Agent[$service_name], 'bamboo_user_user')
  $java_home = getparam(Bamboo_agent::Agent[$service_name], 'java_home')

  case $::operatingsystem {
    'Ubuntu': {
      case $::lsbdistcodename {
        'xenial': {
          $init_path        = '/lib/systemd/system'
          $service_template = 'bamboo_agent/unit.erb'
          $initscript       = "${init_path}/${service_name}.service"
        }
        default: {
          $init_path        = '/etc/init.d'
          $service_template = 'bamboo_agent/init.sh.erb'
          $initscript       = "${init_path}/${service_name}"
        }
      }
    }
    'Redhat','CentOS': {
      case $::operatingsystemmajrelease {
        '7': {
          $init_path        = '/lib/systemd/system'
          $service_template = 'bamboo_agent/unit.erb'
          $initscript       = "${init_path}/${service_name}.service"
        }
        default: {
          $init_path        = '/etc/init.d'
          $service_template = 'bamboo_agent/init.sh.erb'
          $initscript       = "${init_path}/${service_name}"
        }
      }
    }
    'Windows': {

    }
    default: {
      fail("bamboo-agent module is not supported on ${::osfamily}")
    }
  }

  if $::osfamily != 'Windows' {
    file {$initscript:
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      content => template($service_template),
    }

    service { $service_name:
      ensure  => running,
      enable  => true,
      require => File[$initscript],
    }
  }
  else {
    exec { $service_name :
      command  => "New-Service -Name ${service_name} -StartupType Automatic -BinaryPathName \"${agent_home}\\bin\\wrapper.exe -s \\${agent_home}\\conf\\wrapper.conf\"",
      unless   => "Get-Service MyService; exit (1-[int]$?)",
      provider => powershell
    }
  }
}
