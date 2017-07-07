# Defines properties in the wrapper.conf file
# @param home The home directory of the bamboo-agent user
# @param properties A hash of options to add to the wrapper.conf file
define bamboo_agent::wrapper_conf (
  $home,
  $agent = $title,
  $properties = {},
  )
{
  case $facts['os']['family'] {
    'Debian','RedHat': {
      $path = "${home}/conf/wrapper.conf"
    }
    'Windows': {
      $path = "${home}\\conf\\wrapper.conf"
    }
    default: {
      $path = "${home}/conf/wrapper.conf"
    }
  }

  $properties.each |String $key, String $value| {
    file_line{"${agent}-${key}":
      ensure => present,
      path   => $path,
      line   => "${key}=${value}",
      match  => "^${key}="
    }
  }
}
