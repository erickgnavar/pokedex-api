FROM elixir:1.10-alpine as build

ENV MIX_ENV=prod

# install build dependencies
RUN apk --update add build-base

WORKDIR /app

# setup hex + rebar
RUN mix local.hex --force && mix local.rebar --force

# install mix dependencies
COPY mix.exs .
COPY mix.lock .
COPY config config

RUN mix do deps.get --only=prod, compile

COPY priv priv
COPY lib lib
RUN mix compile

RUN mix release

FROM alpine:3.9

RUN apk add --update bash openssl

WORKDIR /rel

COPY --from=build /app/_build/prod/rel/ .

CMD /rel/pokedex/bin/pokedex start
