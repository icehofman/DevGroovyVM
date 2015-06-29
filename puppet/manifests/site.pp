include apt

node default {
	stage {
		"one": ;
		"two": ;
		"tree": ;
		"four": ;
		"five": ;
		"six": ;
		"seven": ;
		"eight": ;
	}

	class {
		"pre_requisites": stage => "one";
		"update": 				stage => "two";
		"gnome": 					stage => "tree";
		"java_8": 				stage => "four";
		"smartgit":				stage => "five";
		"dev":						stage => "six";
		"groovy":					stage => "seven";
		"intelliJ":				stage => "eight";
	}

	Stage["one"]   ->
	Stage["two"]   ->
	Stage["tree"]  ->
	Stage["four"]  ->
	Stage["five"]  ->
	Stage["six"]   ->
	Stage["seven"] ->
	Stage["eight"]
}

class pre_requisites {
	class { "archive::prerequisites": }
	apt::ppa { 'ppa:webupd8team/java': }
	apt::ppa { 'ppa:eugenesan/ppa': }
	apt::ppa { 'ppa:cwchien/gradle': }
	apt::ppa { 'ppa:webupd8team/atom': }
}

class update {
	exec { 'apt-get-update':
		command     => '/usr/bin/apt-get update',
		refreshonly => true,
	}
}

class java_8 {
	package { 'oracle-java8-installer':
		ensure   => installed,
	}

	exec { "accept_license":
		command   => "echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections && echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections",
		cwd       => "/home/vagrant",
		user      => "vagrant",
		path      => "/usr/bin/:/bin/",
		before    => Package["oracle-java8-installer"],
		logoutput => true,
	}
}

class gnome {
	Package { ensure => "installed" }
	package { 'xorg': }
	package { 'gnome-core': }
	package { 'gnome-system-tools': }
	package { 'gnome-app-install': }
}

	class smartgit {
		package { 'smartgit':
			ensure => installed,
	}
}

class dev {
	Package { ensure => "installed" }
	package { 'maven': }
	package { 'gradle': }
	package { 'atom': }
}

class groovy {
	#package {'unzip':}

	class { 'gvm' :
		owner   => 'vagrant',
		group   => 'vagrant',
		homedir => '/home/vagrant',
}

	gvm::package { 'groovy':
		version    => '2.4.3',
		is_default => true,
		ensure     => present
	}
}

class intelliJ {
	#class { "archive::prerequisites": }

	class { 'idea::ultimate':
  	version => '14.1.4',
	}
}
