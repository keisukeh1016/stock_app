FROM ruby:2.7.1

RUN apt update -y \
      && apt install -y nodejs postgresql-client

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
      && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt update -y \
      && apt install -y yarn

RUN mkdir /stock_app
WORKDIR /stock_app

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

COPY package.json .
COPY yarn.lock .
RUN yarn install

COPY . .
RUN chmod 777 docker/wait-postgres.sh

EXPOSE 3000