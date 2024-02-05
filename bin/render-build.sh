#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
./bin/rails assets:precompile
./bin/rails assets:clean

# ./bin/rake RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1 db:reset

# TODO: あとで消す
#  up     20240115065558  Devise create users
#  up     20240115095154  Create user authentications
#  up     20240117114908  Create games
#  up     20240117114937  Create characters
#  up     20240117115037  Create plays
#  up     20240117115051  Create challenges
###  up     20240117115156  Create play challenges
###  up     20240117115235  Create play results
#  up     20240117131100  Create notes
#  up     20240201012158  Create challenge references
###  up     20240201115929  Create user preferences
#  up     20240204041302  Add description column to user
###  up     20240204225951  Change plays comment
./bin/rails db:migrate:down VERSION='20240204225951' #Change plays comment
./bin/rails db:migrate:down VERSION='20240201115929' #Create user preferences
./bin/rails db:migrate:down VERSION='20240117115235' #Create play results
./bin/rails db:migrate:down VERSION='20240117115156' #Create play challenges

# ./bin/rails db:migrate
# ./bin/rails db:seed_fu
