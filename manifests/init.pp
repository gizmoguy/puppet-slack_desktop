# Class slack_desktop
# ===========================
#
# Puppet module for installing slack desktop client.
#
# Parameters
# ----------
#
# * `repo_add_once`
# This option is used by the Slack cronjob. If true, cronjob will
# install slack GPG key and slack sources.list.d file.
#
# * `repo_reenable_on_distupgrade`
# This option is used by the Slack cronjob. If true, cronjob will
# re-enable the slack sources.list.d file after an Ubuntu release upgrade.
#
# Examples
# --------
#
# @example
#    class { 'slack_desktop':
#    }
#
# Authors
# -------
#
# Brad Cowie <brad@wand.net.nz>
#
# Copyright
# ---------
#
# Copyright 2016 Brad Cowie, unless otherwise noted.
#
class slack_desktop (
  $package_ensure               = $slack_desktop::params::package_ensure,
  $package_name                 = $slack_desktop::params::package_name,
  $package_provider             = $slack_desktop::params::package_provider,
  $repos_ensure                 = $slack_desktop::params::repos_ensure,
  $repo_add_once                = $slack_desktop::params::repo_add_once,
  $repo_reenable_on_distupgrade = $slack_desktop::params::repo_reenable_on_distupgrade,
) inherits slack_desktop::params {

  validate_string($package_ensure)
  validate_string($package_name)
  validate_string($package_provider)
  validate_bool($repos_ensure)
  validate_bool($repo_add_once)
  validate_bool($repo_reenable_on_distupgrade)

  case $::osfamily {
    'Debian': {
      include '::slack_desktop::repo::apt'
    }
    default: {
    }
  }

  include '::slack_desktop::install'
  include '::slack_desktop::config'

  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'slack_desktop::begin': }
  anchor { 'slack_desktop::end': }

  Anchor['slack_desktop::begin'] -> Class['::slack_desktop::install']
    -> Class['::slack_desktop::config'] -> Anchor['slack_desktop::end']

}
