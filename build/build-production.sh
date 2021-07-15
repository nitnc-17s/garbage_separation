cd `dirname $0`
cd ../
docker-compose -f production.docker-compose.yml build
docker-compose -f production.docker-compose.yml run --rm rails bundle exec rake db:create ridgepole:apply db:seed db:seed_fu
