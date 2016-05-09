# Class slack_desktop::config
class slack_desktop::config {

  $repo_add_once                = $slack_desktop::repo_add_once
  $repo_reenable_on_distupgrade = $slack_desktop::repo_reenable_on_distupgrade

  case $::osfamily {
    'Debian': {
      file { '/etc/default/slack':
        ensure  => file,
        content => template('slack_desktop/default.erb'),
        mode    => '0644',
        owner   => '0',
        group   => '0',
      }
    }
    default: {
    }
  }
}
