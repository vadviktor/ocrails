FROM ruby:3.2.2

ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=1

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        build-essential \
        libpq-dev \
        libvips \
        libvips-dev \
        libvips-tools

RUN mkdir /app
WORKDIR /app
COPY . /app

RUN bundle config set --local without 'development test' && bundle install --jobs 4 --retry 3
