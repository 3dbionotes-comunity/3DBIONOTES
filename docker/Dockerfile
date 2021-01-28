# https://github.com/phusion/passenger-docker#selecting_default_ruby
FROM phusion/passenger-customizable:1.0.12

#Install dependencies
RUN apt-get update && apt-get install -y \
    libgsl-dev \
    libmysqlclient-dev \
    && rm -rf /var/lib/apt/lists/*

#Configure and prepare environment
COPY --chown=app:app . /opt/3DBIONOTES
RUN mv /opt/3DBIONOTES/docker/files/3dbionotes.conf /etc/nginx/sites-enabled/3dbionotes.conf && rm -f /etc/service/nginx/down
#RUN bash -lc 'rvm install ruby-2.4.1' && bash -lc 'rvm uninstall ruby-2.4.10' && bash -lc 'rvm --default use ruby-2.4.1'
RUN bash -lc 'rvm install ruby-2.4.1' && bash -lc 'rvm --default use ruby-2.4.1'
WORKDIR /opt/3DBIONOTES
RUN bundle && RAILS_ENV=production bundle exec rake assets:precompile
ENTRYPOINT ["service", "nginx", "start"]