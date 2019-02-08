FROM ruby:2.6.1-alpine
MAINTAINER sergio brocos <sergiobrocos@gmail.com>

# Minimal requirements to run a Rails app
RUN apk add --no-cache --update build-base \
                                linux-headers \
                                git \
                                postgresql-dev \
                                postgresql-client \
                                nodejs \
                                tzdata

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock ./
RUN BUNDLE_PATH=/bundle gem install bundler && bundle install -j 2

# Copy the application into the container
COPY . APP_HOME
EXPOSE 3000