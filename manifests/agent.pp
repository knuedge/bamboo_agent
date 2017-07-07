# defined type to create bamboo agents
#
#
# @param home home directory for the bamboo agent user
# @param server_url url for the bamboo server the agent talks to
# @param capabilities hash of custom capabilities for the agent
# @param manage_user Create the bamboo service account(s)
# @param manage_groups Create the groups specified for bamboo agent user
# @param manage_home If set to true, will create the home directory for the bamboo agent user
# @param username Username for bamboo-agent service account
# @param user_groups A list of groups to add the bamboo-agent user too
# @param manage_capabilities Whether the module should manage the capabilities file for the agent
# @param wrapper_conf_properties Additonal java arguments to put in wrapper.conf
# @param check_certificate Whether to have wget check the certificate of the Bamboo server when downloading the installer jar
# @param java_home Specify a value for the `JAVA_HOME` environment variable to include in the system init script
define bamboo_agent::agent (
  String            $agent_name              = $title,
  String            $server_url              = '',
  Optional[String]  $bamboo_user_home        = '',
  Optional[String]  $bamboo_agent_home       = '',
  Optional[Hash]    $capabilities            = {},
  Optional[Boolean] $manage_user             = true,
  Optional[Boolean] $manage_groups           = true,
  Optional[Boolean] $manage_home             = true,
  Optional[String]  $username                = '',
  Optional[String]  $service_name            = '',
  Optional[Array]   $user_groups             = [],
  Optional[Boolean] $manage_capabilities     = true,
  Optional[Hash]    $wrapper_conf_properties = {},
  Optional[Boolean] $check_certificate       = true,
  Optional[String]  $java_home               = '',
  Optional[String]  $bamboo_tools            = ''
) {
  Bamboo_agent::Service {$agent_name:
    service_name => $service_name,
    agent_home   => $bamboo_agent_home
  }

  if $facts['os']['family'] == 'Windows' {
    ensure_resource('windows_env', 'WINDOWS_JAVA_HOME', {
      ensure    => present,
      variable  => 'JAVA_HOME',
      value     => $java_home,
      mergemode => clobber
    })

    if $bamboo_tools != undef {
      ensure_resource('windows_env', 'WINDOWS_BAMBOO_TOOLS', {
        ensure    => present,
        variable  => 'BAMBOO_TOOLS',
        value     => $bamboo_tools,
        mergemode => clobber
      })
    }
  }

  if $manage_groups == true {
    group {$user_groups:
      ensure => present,
    }
  }
  # setup user
  if $manage_user == true {
    ensure_resource('user', $username, {
      ensure  => present,
      comment => "bamboo-agent ${username}",
      home    => $bamboo_user_home,
      shell   => '/bin/bash',
      groups  => $user_groups,
      system  => true,
    })
  }

  if $manage_home == true {
    ensure_resource('file', $bamboo_user_home, {
      ensure => directory,
      owner  => $username,
    })
  }

  case $facts['os']['family'] {
    'Debian', 'RedHat': {
      $mkdir_command = "mkdir -p ${bamboo_agent_home}"
      $provider = 'shell'
    }
    'Windows': {
      $mkdir_command = "cmd.exe /c Mkdir ${bamboo_agent_home}"
      $provider = 'windows'
    }
    default: {
      $mkdir_command = "mkdir -p ${bamboo_agent_home}"
      $provider = 'shell'
    }
  }

  exec { "create bamboo_agent_home: ${bamboo_agent_home}":
    command  => $mkdir_command,
    path     => $::path,
    provider => $provider,
    creates  => $bamboo_agent_home
  }
  -> file {$bamboo_agent_home:
    ensure  => directory,
    owner   => $username,
    recurse => true
  }

  bamboo_agent::install{$agent_name:
    home              => $bamboo_agent_home,
    username          => $username,
    server_url        => $server_url,
    check_certificate => $check_certificate,
    java_home         => $java_home,
  }

  if $manage_capabilities == true {
    bamboo_agent::capabilities{ $agent_name:
      home         => $bamboo_agent_home,
      username     => $username,
      capabilities => $capabilities,
      require      => [ File[$bamboo_agent_home], Bamboo_agent::Install[$agent_name] ],
      notify       => Bamboo_agent::Service[$agent_name]
    }
  }

  bamboo_agent::wrapper_conf {$agent_name:
    home       => $bamboo_agent_home,
    properties => $wrapper_conf_properties,
    notify     => Bamboo_agent::Service[$agent_name]
  }

  Bamboo_agent::Install[$agent_name]
  -> Bamboo_agent::Service[$agent_name]

}
