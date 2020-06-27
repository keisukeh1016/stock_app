#!/bin/bash

set -e

bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed
bundle exec rails stock:name
bundle exec rails stock:price_man
bundle exec rails stock:portfolio