touch secrets.env

docker-compose build

docker-compose run --rm rails bundle install
docker-compose run --rm rails bundle exec rake db:create ridgepole:apply db:seed db:seed_fu
