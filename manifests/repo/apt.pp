# Class slack_desktop::repo::apt
# requires
#   puppetlabs-apt
class slack_desktop::repo::apt(
  $location    = 'https://packagecloud.io/slacktechnologies/slack/debian/',
  $release     = 'jessie',
  $repos       = 'main',
  $include_src = false,
  $key         = '418A7F2FB0E1E6E7EABF6FE8C2E73424D59097AB',
  $key_content = template('slack_desktop/orig-repo.pub.key.erb'),
  ) {

  Class['slack_desktop::repo::apt'] -> Package<| title == 'slack-desktop' |>

  $ensure_source = $slack_desktop::repos_ensure ? {
    false   => 'absent',
    default => 'present',
  }

  # NB: The original key we used above is the public PackageCloud
  # key which we are now moving away from and moving to a key that
  # Slack uses solely for Slack packages. However, in order to not
  # break updates for people, we need to ship an update where we
  # include both keys. In a future update, we'll remove the
  # PackageCloud key.
  apt::key { 'packagecloud-slack':
    key         => 'DB085A08CA13B8ACB917E0F6D938EC0D038651BD',
    key_content => template('slack_desktop/repo.pub.key.erb'),
  }

  apt::source { 'slack':
    ensure      => $ensure_source,
    location    => $location,
    release     => $release,
    repos       => $repos,
    include_src => $include_src,
    key         => $key,
    key_content => $key_content,
  }
}
