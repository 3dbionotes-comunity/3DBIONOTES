FROM phusion/passenger-ruby24:1.0.14

RUN apt-get update && apt-get install -y \
    libgsl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN rm /etc/nginx/sites-enabled/default && rm /etc/service/nginx/down
ADD config/docker/3dbionotes.conf /etc/nginx/sites-enabled/3dbionotes.conf
RUN mkdir /home/app/webapp
WORKDIR /home/app/3DBIONOTES
COPY --chown=app:app . /home/app/3DBIONOTES
RUN bundle install
RUN SECRET_KEY_BASE="$(bundle exec rake secret)" && sed -i -e "s/prodkey/$SECRET_KEY_BASE/g" config/secrets.yml

ENTRYPOINT ["config/docker/entrypoint.sh"]