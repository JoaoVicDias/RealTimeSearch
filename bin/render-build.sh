#!/usr/bin/env bash
# exit on error
set -o errexit

bundle exec rails db:migrate
bundle install
bundle exec rails assets:precompile