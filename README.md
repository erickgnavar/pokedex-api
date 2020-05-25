# Pokedex

Pokedex api using data from https://pokemondb.net

## Deploy to heroku

Setup container based stack:

`heroku stack:set container`

Setup postgres addon:

`heroku addons:create heroku-postgresql:hobby-dev`

Setup required environment variables:

`heroku config:set POOL_SIZE=10`

Once deployment is done run migrations:

`heroku run "POOL_SIZE=2 /rel/pokedex/bin/pokedex eval Pokedex.Release.migrate"`

and fetch and insert data:

`heroku run "POOL_SIZE=2 /rel/pokedex/bin/pokedex eval Pokedex.Release.fill_data"`
