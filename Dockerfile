FROM ruby:2.6.3

RUN apt-get update -qq && \
  apt-get upgrade -y && \
  apt-get install -y \
  build-essential \
  nodejs \
  npm

RUN npm install -g n
RUN n 14.17.0
RUN apt-get purge -y nodejs npm

RUN npm install --g yarn

RUN mkdir /app
WORKDIR /app
