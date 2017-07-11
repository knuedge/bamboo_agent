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
  $bamboo_manage_user = $::osfamily ? {
    'Windows' => false,
    default => true
  }
  $bamboo_manage_user_home = $::osfamily ? {
    'Windows' => false,
    default => true
  }
  $bamboo_manage_groups = $::osfamily ? {
    'Windows' => false,
    default => false
  }
  $bamboo_manage_capabilities = true

  # Bamboo base server
  $bamboo_server_url = 'https://bamboo.example.com'
  $bamboo_server_check_certificate = true

  # Bamboo Agent Settings
  $bamboo_agent_capabilities = {}
  $bamboo_agent_wrapper_properties = {}

  # Java settings
  $java_home = undef
}
