case $facts['os']['family'] {
  'Debian', 'RedHat': {
    $bamboo_home         = '/opt/atlassian/bamboo/agent%s'
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
    $bamboo_user         = 'ZMTSATFS01'
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
      'system.builder.Command.Force\ Windows\ Agent'       => 'C:\\Windows\\System32\\print.exe',
      'system.builder.Maven\ 3x.Maven\ 3'                  => 'D:\\Maven\\apache-maven-3.3.9',
      'system.builder.Maven\ 3x.Maven\ Windows'            => 'D:\\Maven\\apache-maven-3.3.9',
      'system.builder.Command.MergeSoapUITestResults'      => 'C:\\BuildTools\\MergeSoapUITestResults\\MergeSoaoUITestResults.exe',
      'system.builder.Command.MijnZaakMergeTool\ 1\.0'     =>
        'C:\\BuildTools\\MijnZaakMergeTool_1_0\\MergeDevelopmentSandboxToSharePoint.exe',
      'system.builder.Command.eKantonMergeTool'            =>
        'C:\\BuildTools\\MergeSandboxToSharepint\\MergeDevelopmentSandboxToSharePoint.exe',
      'system.builder.Node\.js.Node\.js'                   => 'C:\\Program\ Files\\nodejs\\node.exe',
      'system.builder.Command.Nuget'                       => 'C:\\BuildTools\\Nuget\\nuget.exe',
      'system.builder.puppet-lint.Puppet\ Lint'            => 'puppet-lint',
      'system.builder.Command.Python'                      => 'C:\\Program\ Files\\Python\\python.exe',
      'system.builder.Command.SoapUI\ 5\.0\.0\ \(32bit\)'  => 'C:\\Program\ Files(x86)\\SmartBear\\SoapUI-5.0.0\\bin\\testrunner.bat',
      'system.builder.Command.Toezicht\ Merge\ Tool\ 1\.0' =>
        'C:\\BuildTools\\ToezichtMergeTool_1_0\\MergeDevelopmentSandboxToSharePoint.exe',
      'system.builder.Command.Typescript\ Compiler'        => 'C:\\Program\ Files\(x86\)\\Microsoft\ SDKs\\TypeScript\\1.7\\tsc.exe',
      'system.builder.Command.curl'                        => 'C:\\BuildTools\\curl-7.54.0-win64-mingw\\bin\\curl.exe',
      ## Visual Studio
      'system.builder.Visual\ Studio.Visual\ Studio\ 2012' => 'C:\\Program\ Files\(x86\)\\Microsoft\ Visual\ Studio\ 11.0\\Common7\\IDE',
      'system.builder.Visual\ Studio.Visual\ Studio\ 2013' => 'C:\\Program\ Files\(x86\)\\Microsoft\ Visual\ Studio\ 12.0\\Common7\\IDE',
      'system.builder.Visual\ Studio.Visual\ Studio\ 2015' => 'C:\\Program\ Files\(x86\)\\Microsoft\ Visual\ Studio\ 14.0\\Common7\\IDE',
      ## MSBuild
      'system.builder.MSBuild.MSBuild\ v2\.0\(32bit\)'  => 'C:\\Windows\\Microsoft.NET\\Framework\\v2.0.50727\\MSBuild.exe',
      'system.builder.MSBuild.MSBuild\ v2\.0\(64bit\)'  => 'C:\\Windows\\Microsoft.NET\\Framework64\\v2.0.50727\\amd64\\MSBuild.exe',
      'system.builder.MSBuild.MSBuild\ v3\.5\(32bit\)'  => 'C:\\Windows\\Microsoft.NET\\Framework\\v3\.5\\MSBuild.exe',
      'system.builder.MSBuild.MSBuild\ v3\.5\(64bit\)'  => 'C:\\Windows\\Microsoft.NET\\Framework64\\v3\.5\\amd64\\MSBuild.exe',
      'system.builder.MSBuild.MSBuild\ v4\.0\(32bit\)'  => 'C:\\Windows\\Microsoft.NET\\Framework\\v4.0.30319\\MSBuild.exe',
      'system.builder.MSBuild.MSBuild\ v4\.0\(64bit\)'  => 'C:\\Windows\\Microsoft.NET\\Framework64\\v4.0.30319\\amd64\\MSBuild.exe',
      'system.builder.MSBuild.MSBuild\ v12\.0\(32bit\)' => 'C:\\Program\ Files(x86)\\MSBuild\\12.0\\bin\\MSBuild.exe',
      'system.builder.MSBuild.MSBuild\ v12\.0\(64bit\)' => 'C:\\Program\ Files(x86)\\MSBuild\\12.0\\bin\\amd64\\MSBuild.exe',
      'system.builder.MSBuild.MSBuild\ v14\.0\(32bit\)' => 'C:\\Program\ Files(x86)\\MSBuild\\14.0\\bin\\MSBuild.exe',
      'system.builder.MSBuild.MSBuild\ v14\.0\(64bit\)' => 'C:\\Program\ Files(x86)\\MSBuild\\14.0\\bin\\amd64\\MSBuild.exe',
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
