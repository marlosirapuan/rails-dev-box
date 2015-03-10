# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

echo updating package information
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

install 'development tools' build-essential

### Bundler
echo installing Bundler
gem install bundler -N >/dev/null 2>&1

### Utils
install Git git
install memcached memcached
install Redis redis-server

### DB postgresql
install PostgreSQL postgresql postgresql-contrib libpq-dev
sudo -u postgres createuser --superuser vagrant

### DB mysql
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
install MySQL mysql-server libmysqlclient-dev
mysql -uroot -proot <<SQL
GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'root';
FLUSH PRIVILEGES;
SQL

### Extras
install 'Nokogiri dependencies' libxml2 libxml2-dev libxslt1-dev
install 'ExecJS runtime' nodejs
install 'NPM' npm

# Needed for docs generation.
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

echo 'all set, installing rvm...'
