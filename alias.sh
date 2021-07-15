project_name='garbage_separation'

alias docker-compose="docker-compose -p $project_name"

alias build="docker-compose build"
alias up="docker-compose up"
alias stop="docker-compose stop"

alias spring="rm -f tmp/pids/spring.pid tmp/pids/spring.sock && up spring"
alias app="rm -f tmp/pids/server.pid && up rails"

alias bundle="docker-compose run -e RAILS_ENV=development --rm rails bundle"
alias rails="docker-compose run -e RAILS_ENV=development --rm rails bundle exec rails"
alias rake="docker-compose run -e RAILS_ENV=development --rm rails bundle exec rake"
alias seed_fu="rake db:seed_fu FIXTURE_PATH=db/seeds/development/"
alias rspec="docker-compose run -e RAILS_ENV=test --rm spring spring rspec"
alias rubocop="docker-compose run -e RAILS_ENV=development --rm rails bundle exec rubocop -DESP"
alias rubocop_show_class="docker-compose run -e RAILS_ENV=development --rm rails bundle exec rubocop -D"
alias guard="docker-compose run -e RAILS_ENV=test --rm rails bundle exec guard"
alias rswag="docker-compose run -e RAILS_ENV=test --rm rails bundle exec rails rswag:specs:swaggerize"
