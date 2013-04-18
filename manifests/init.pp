class spamassassin(
  $enabled  = 1,
  $nice     = 15,
  $cron     = 1
) {
  package { 'spamassassin':
    ensure  => present,
  } ->

  file { '/etc/default/spamassassin':
    ensure  => present,
    content => template('spamassassin/default.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => 0644,
    require => Package['spamassassin'],
    notify  => Service['spamassassin'],
  } ->

  service { 'spamassassin':
    ensure      => running,
    hasstatus   => true,
    hasrestart  => true,
    require     => Package['spamassassin'],
  }
}