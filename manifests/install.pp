# download and install install the jar file
# this defined type is private
#
# @param home home directory for bamboo-agent inst directory
# @param username username of the bamboo-agent account
# @param server_url the url for the bamboo server
define bamboo_agent::install (
  String           $home,
  String           $username,
  String           $server_url,
  Boolean          $check_certificate = true,
  Optional[String] $java_home         = undef,
) {
  assert_private()

  $path = $java_home ? {
    Undef   => [ '/bin', '/usr/bin', '/usr/local/bin' ],
    default => [ "${java_home}/bin", '/bin', '/usr/bin', '/usr/local/bin' ],
  }

  $no_check_cert_flag = $check_certificate ? {
    false   => '--no-check-certificate',
    default => ''
  }

  case $facts['os']['family'] {
    'Debian', 'RedHat': {
      $download_command = "wget ${no_check_cert_flag} ${server_url}/agentServer/agentInstaller/atlassian-bamboo-agent-installer.jar"
      $install_command = "java -jar -Dbamboo.home=${home} atlassian-bamboo-agent-installer.jar ${server_url}/agentServer/ install"
      $real_username = $username
      $provider = 'shell'
    }
    'Windows': {
      $download_command = "(new-object System.Net.WebClient).Downloadfile(\"${server_url}/agentServer/agentInstaller/atlassian-bamboo-agent-installer.jar\", \"${home}\\atlassian-bamboo-agent-installer.jar\")"
      $install_command = "${java_home}\\bin\\java.exe -jar -Dbamboo.home=${home} atlassian-bamboo-agent-installer.jar ${server_url}/agentServer/ install"
      $provider = 'powershell'
      $real_username = undef
    }
    default: {
      fail("bamboo-agent module is not supported on ${::osfamily}")
    }
  }

  exec {"download-${title}-bamboo-agent-jar":
    command  => $download_command,
    cwd      => $home,
    user     => $real_username,
    provider => $provider,
    path     => ['/usr/bin', '/bin'],
    creates  => "${home}/atlassian-bamboo-agent-installer.jar",
    require  => File[$home],
  }

  exec { "install-${title}-bamboo-agent":
    command => $install_command,
    cwd     => $home,
    user    => $real_username,
    path    => $path,
    creates => "${home}/bin/bamboo-agent.sh",
    require => Exec["download-${title}-bamboo-agent-jar"],
  }
}
