#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
./bin/rails assets:precompile
./bin/rails assets:clean

# ./bin/rake RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1 db:reset
# for the temporary migration

./bin/rails db:migrate
./bin/rails db:seed_fu
