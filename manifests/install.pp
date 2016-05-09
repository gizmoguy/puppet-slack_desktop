# Class slack_desktop::install
class slack_desktop::install {

  $package_ensure   = $slack_desktop::package_ensure
  $package_name     = $slack_desktop::package_name
  $package_provider = $slack_desktop::package_provider

  package { 'slack-desktop':
    ensure   => $package_ensure,
    name     => $package_name,
    provider => $package_provider,
  }
}
