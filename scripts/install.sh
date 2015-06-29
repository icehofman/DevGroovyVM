/vagrant/scripts/./update.sh
apt-get install -y puppet
puppet module install puppetlabs-apt
puppet module install paulosuzart-gvm
puppet module install gini-idea
