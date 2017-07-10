case $facts['os']['family'] {
  'Debian', 'RedHat': {
    $java_home           = '/opt/jdk1.8.0_92'
    $bamboo_manage_group = false
    $bamboo_tools        = '/var/atlassian/bamboo/tools'
    $capabilities        = {
      ## Basic OS capabilities
      'Hostname' => $::hostname,
      'Server'   => $::hostname,
      'OS'       => $facts['os']['family'],
      'Linux'    => true,
      ## JDK capabilities
      'system.jdk.JDK'            => "${bamboo_tools}/jdk1.8.0_65",
      'system.jdk.JDK\ 1.8.0_45'  => "${bamboo_tools}/jdk1.8.0_45",
      'system.jdk.JDK\ 1.8.0_65'  => "${bamboo_tools}/jdk1.8.0_65",
      'system.jdk.JDK\ 1.8.0_111' => "${bamboo_tools}/jdk1.8.0_111",
      'system.jdk.JDK\ 1.8.0_92'  => "${bamboo_tools}/jdk1.8.0_92",
      ## VCS capabilities
      'system.git.executable'      => '/usr/bin/git',
      'system.builder.Command.SVN' => '/usr/bin/svn',
      ## Executables
      'system.builder.Command.Python'           => '/usr/bin/python',
      'system.builder.Command.Bash'             => '/bin/bash',
      'system.builder.Command.curl'             => '/usr/bin/curl',
      'system.builder.Command.pwd'              => '.',
      'system.builder.puppet-lint.Puppet\ Lint' => 'puppet-lint',
      'system.builder.Command.wlfullclient'     => "${bamboo_tools}/wlfullclient",
      'system.builder.mvn3.Maven\ 3'            => "${bamboo_tools}/apache-maven-3.0.5",
      'system.builder.node\.js.Node\.js'        => "${bamboo_tools}/node-v0.12.4-linux-x64/bin/node",
      ## Sonar
      'system.builder.Sonar\ Runner.Sonar\ Scanner\ 2\.6\.1' => "${bamboo_tools}/sonar-scanner-2.6.1",
      'system.builder.Sonar\ Runner.Sonar-runner-2\.4'       => "${bamboo_tools}/sonar-runner-2.4",
      ## PhantomJS
      'system.builder.PhantomJS.PhantomJS_1_9_8' => "${bamboo_tools}/phantomjs-1.9.8-linux-x86_64/bin/phantomjs",
      'system.builder.PhantomJS.PhantomJS_2_1_1' => "${bamboo_tools}/phantomjs-2.1.1-linux-x86_64/bin/phantomjs",
      ## ANT
      'system.builder.ant.Ant\ 1\.9' => "${bamboo_tools}/apache-ant-1.9.3",
    }
  }
  'Windows': {
    $java_home           = 'C:\\Program\ Files\\Java\\jdk1.8.0_66'
    $bamboo_user         = 'bambooUser'
    $capabilities        = {
      ## Basic OS capabilities
      'Hostname' => $::hostname,
      'Server'   => $::hostname,
      'OS'       => $facts['os']['family'],
      'Windows'  => true,
      ## JDK capabilities
      'system.jdk.JDK'            => 'C:\\Program\ Files\\Java\\jdk1.8.0_66',
      'system.jdk.JDK\ 1.7'       => 'C:\\Program\ Files\\Java\\jdk1.7.0_67',
      'system.jdk.JDK\ 1.8'       => 'C:\\Program\ Files\\Java\\jdk1.8.0_66',
      'system.jdk.JDK\ 1.8.0_65'  => 'C:\\Program\ Files\\Java\\jdk1.8.0_65',
      'system.jdk.JDK\ 1.8.0_66'  => 'C:\\Program\ Files\\Java\\jdk1.8.0_66',
      'system.jdk.JDK\ 1.8.0_111' => 'C:\\Program\ Files\\Java\\jdk1.8.0_111',
      ## VCS capabilities
      'system.git.executable' => '/usr/bin/git',
      ## Executables
      'system.builder.Maven\ 3x.Maven\ 3'       => 'D:\\Maven\\apache-maven-3.3.9',
      'system.builder.Maven\ 3x.Maven\ Windows' => 'D:\\Maven\\apache-maven-3.3.9'
    }
  }
  default: {
    fail("bamboo-agent module is not supported on ${::osfamily}")
  }
}

class {'bamboo_agent':
  agents => {
    'bamboo-agent1' => {
      java_home               => $java_home,
      username                => $bamboo_user,
      capabilities            => $capabilities,
      wrapper_conf_properties => {
        'wrapper.max_failed_invocations' => '20',
        'wrapper.java.additional.3'      => '-Djava.io.tmpdir=../temp'
      }
    },
    'bamboo-agent2' => {
      java_home               => $java_home,
      username                => $bamboo_user,
      capabilities            => $capabilities,
      wrapper_conf_properties => {
        'wrapper.max_failed_invocations' => '20',
        'wrapper.java.additional.3'      => '-Djava.io.tmpdir=../temp'
      }
    }
  }
}
