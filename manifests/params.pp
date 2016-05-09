# Class slack_desktop::params
class slack_desktop::params {

  case $::osfamily {
    'Debian': {
      $package_ensure   = 'installed'
      $package_name     = 'slack-desktop'
      $package_provider = 'apt'
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

  #install
  $repos_ensure                 = true
  #config
  $repo_add_once                = false
  $repo_reenable_on_distupgrade = false
}
