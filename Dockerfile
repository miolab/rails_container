FROM ruby:2.7.4

WORKDIR /usr/src/app

RUN apt-get update -qq && \
  apt-get upgrade -y && \
  apt-get install -y \
  build-essential \
  nodejs \
  npm

RUN npm install -g n
RUN n 14.17.0
RUN apt-get purge -y nodejs npm
RUN apt-get clean

RUN npm install -g yarn

# RUN gem install rails -v 6.0.3
RUN gem install rails

COPY Gemfile /usr/src/app/Gemfile
COPY Gemfile.lock /usr/src/app/Gemfile.lock

RUN bundle install

RUN yarn

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
