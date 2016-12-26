#!/bin/bash          
set -x
export HOME=/root 
gem install rails --version '3.2.12' 
apt-get install sqlite3 libsqlite3-dev
bundle install 
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed 
bundle exec rake spec 