# == Class: bamboo_agent::params
# Author: Siebren Zwerver
#

class bamboo_agent::params {
  # Bamboo user settings
  $bamboo_user_user   = 'bamboo'
  $bamboo_user_group  = 'bamboo'
  $bamboo_user_home   = '/home/bamboo'
  $bamboo_user_groups = ['bamboo']

  # Bamboo manage settings
  $bamboo_manage_user = $facts['os']['family'] ? {
    'Windows' => false,
    default => true
  }
  $bamboo_manage_user_home = $facts['os']['family'] ? {
    'Windows' => false,
    default => true
  }
  $bamboo_manage_groups = $facts['os']['family'] ? {
    'Windows' => false,
    default => true
  }
  $bamboo_manage_capabilities = true

  # Bamboo base server
  $bamboo_server_url = 'https://bamboo.example.com'
  $bamboo_server_check_certificate = true

  # Bamboo Agent Settings
  $bamboo_agent_capabilities = {}
  $bamboo_agent_tools = ''
  $bamboo_agent_home_location = $facts['os']['family'] ? {
    'Windows' => 'D:\\Atlassian\\Bamboo\\%s',
    default   => '/opt/atlassian/bamboo/%s'
  }
  $bamboo_agent_wrapper_properties = {}

  # Java settings
  $java_home = $facts['os']['family'] ? {
    'windows' => ' C:\\Windows\\System32\\java.exe',
    default   => '/usr/bin/java'
  }
}
