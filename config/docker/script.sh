#!/bin/sh
cd /opt
git clone https://github.com/3dbionotes-community/3DBIONOTES.git
cd 3DBIONOTES
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby
source /etc/profile
rvm install 2.4.1
rvm use 2.4.1
gem install bundler:1.17.3
sudo apt install -y libgsl-dev libmysqlclient-dev nodejs
bundle install
cp config/database.example.yml config/database.yml
cp config/secrets.example.yml config/secrets.yml
bundle exec rake db:migrate RAILS_ENV=development
bundle exec rails server

CREATE USER 'bionotes'@'localhost' IDENTIFIED BY 'bionotes-1';
CREATE USER 'bionotes'@'%' IDENTIFIED BY 'bionotes-1';

CREATE DATABASE bionotes_development;
CREATE DATABASE bionotes_test;
CREATE DATABASE bionotes_production;

GRANT ALL ON *.* TO 'bionotes'@'localhost';
GRANT ALL ON *.* TO 'bionotes'@'%';