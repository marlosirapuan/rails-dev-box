### RVM
echo installing RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash
source "$HOME/.rvm/scripts/rvm" >> ~/.bash_profile
rvm requirements
echo installing Ruby 2.2.1
rvm install 2.2.1 --default

echo 'all set, rock on!'
