FROM ruby:3.1.1

WORKDIR /opt/app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install
