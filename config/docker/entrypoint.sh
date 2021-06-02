#!/bin/sh
bundle exec rake assets:precompile db:migrate RAILS_ENV=production
chown -R app:app /home/app/3DBIONOTES
service nginx start