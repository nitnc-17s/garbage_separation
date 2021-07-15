FROM ruby:2.6.6-alpine
ENV LANG C.UTF-8
ENV RAILS_ENV="production" DISABLE_SPRING=1

ENV APP_HOME /rails_app
WORKDIR $APP_HOME

COPY . $APP_HOME

RUN /bin/sh build/scripts/apk_install.sh && \
    bundle install --without development test && \
    rm -rf /usr/local/bundle/cache

EXPOSE 3000
CMD bundle exec rails server -b 0.0.0.0
