# variables
$wordpress_tag = "3.5.1"
$wwwroot = "/var/www/html"

# path defaults
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/", "/usr/local/bin/" ] }

# enable the epel yum repo
yumrepo { "epel":
	descr => "Extra Packages for Enterprise Linux 6 - \$basearch",
	baseurl => "http://download.fedoraproject.org/pub/epel/6/\$basearch",
	gpgcheck => "0",
	enabled => "1"
}

# disable SELinux on initial boot (config file should disable for future boots)
#exec { "disable_selinux":
#	command => "setenforce 0 >& /dev/null"
#}

# install packages
$packages = [ "httpd", "mysql", "mysql-server", "mysql-devel", "php", "php-mysql", "php-devel", "php-mbstring", "php-common", "php-cli", "php-gd", "php-pdo", "shadow-utils", "git", "phpMyAdmin", "php-mcrypt", "iptables" ]
package { $packages:
	ensure => "installed",
	require => Yumrepo["epel"]
}
exec { "download_composer":
	command => "curl -O http://getcomposer.org/composer.phar >& /dev/null",
	cwd => "/usr/local/bin",
	onlyif => "test ! -f /usr/local/bin/composer.phar"
}
file { "/usr/local/bin/composer.phar":
	ensure => "present",
	mode => "0755",
	require => Exec['download_composer']
}
file { "/usr/local/bin/composer":
	ensure => "link",
	require => File["/usr/local/bin/composer.phar"],
	target => "/usr/local/bin/composer.phar"
}
exec { "clone_wpcli":
	command => "git clone git://github.com/wp-cli/wp-cli.git /usr/share/wp-cli >& /dev/null",
	onlyif => "test ! -d /usr/share/wp-cli",
	require => Package["git"]
}
exec { "install_wpcli_1":
	command => "/usr/share/wp-cli/utils/dev-build >& /dev/null",
	cwd => "/usr/share/wp-cli",
	onlyif => "test ! -L /usr/bin/wp",
	require => [ Exec["clone_wpcli"], File['/usr/local/bin/composer'] ]
}
exec { "install_wpcli_2":
	command => "composer install",
	cwd => "/usr/share/wp-cli",
	onlyif => "test ! -f /usr/share/wp-cli/composer.lock",
	require => [ Exec["clone_wpcli"], File['/usr/local/bin/composer'] ]
}

# copy config files recursively (wait for packages to drop default files before sync)
file { "/etc":
	ensure => "present",
	group => 'root',
	source => "/vagrant/provision/etc",
	owner => 'root',
	recurse => true,
	require => Package[["phpMyAdmin","httpd"]]
}

# clean out the /var/www/html directory if no wp-config.php file is found (should only run once)
exec { "clean_varwwwhtml":
	command => "rm -rf ${$wwwroot} >& /dev/null",
	onlyif => "test ! -f ${$wwwroot}/wp-config.php",
	require => Package['httpd']
}

# clone wordpress if there is no existing wp-config.php (should only run once)
exec { "clone_wordpress":
	command => "git clone git://github.com/WordPress/WordPress.git ${$wwwroot} >& /dev/null",
	onlyif => "test ! -f ${$wwwroot}/wp-config.php",
	require => [ Package["git"], Exec["clean_varwwwhtml"] ]
}
exec { "checkout_wordpress_branch":
	command => "git checkout ${wordpress_tag}",
	cwd => "${$wwwroot}",
	require => Exec["clone_wordpress"]
}

# pull in composer modules
#exec { "run_composer":
#	command => "composer install",
#	cwd => "/vagrant",
#	onlyif => "test ! -f /vagrant/composer.lock",
#	require => [ File["/usr/local/bin/composer"], Exec["clone_wordpress"] ]
#}

# copy www config files
file { $wwwroot:
	ensure => "present",
	group => "vagrant",
	owner => "vagrant",
	recurse => true,
	# source => "/vagrant/provision/var/www/html",
	require => Exec["clone_wordpress"]
}

# link src folder in repo to wp-content folder in wordpress
file { "${$wwwroot}/wp-content":
	ensure => "link",
	force => true,
	require => Exec["clone_wordpress"],
	target => "/vagrant/src"
}

# create folders that wordpress needs
file { ["${$wwwroot}/wp-content/blogs.dir","${$wwwroot}/wp-content/uploads"]:
	ensure => "directory",
	group => "apache",
	owner => "apache",
	mode => "777",
	require => File["${$wwwroot}/wp-content"]
}

# services
service { "mysqld":
	enable => true,
	ensure => running,
	require => Package['mysql']
}
service { "httpd":
	enable => true,
	ensure => running,
	require => [ Package['httpd'], File['/etc'] ]
}
service { "iptables":
	enable => false,
	ensure => stopped,
	require => Package['iptables']
}

# set mysql root password
exec { "mysql_root_pw":
	command => "mysqladmin -u root password vagrant >& /dev/null",
	onlyif => 'test ! -d /var/lib/mysql/wordpress',
	require => Service['mysqld']
}

# create mysql database if it doesn't already exist
exec { "mysql_create_db":
	command => 'mysql -u root -pvagrant -e "CREATE DATABASE wordpress; GRANT ALL PRIVILEGES ON wordpress.* TO wordpress@localhost IDENTIFIED BY \'wordpress\';" >& /dev/null',
	onlyif => 'test ! -d /var/lib/mysql/wordpress',
	require => Exec['mysql_root_pw']
}

# bootstrap mysql data if there isn't any already
#exec { "mysql_bootstrap_data":
#	command => 'mysql -u root -pvagrant -e "DROP DATABASE wordpress; CREATE DATABASE wordpress;" >& /dev/null; mysql -u root -pvagrant wordpress < /vagrant/provision/wordpress.sql',
#	onlyif => 'test ! -f /var/lib/mysql/wordpress/wp_posts.MYD',
#	require => Exec['mysql_create_db']
#}
