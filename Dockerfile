ARG DISTRO_VERSION=ubuntu-noble-20241015
ARG ELIXIR_VERSION=1.17.3
ARG OTP_VERSION=27.2
ARG BUILDER_IMAGE="mirror.gcr.io/hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-${DISTRO_VERSION}"

FROM ${BUILDER_IMAGE}

RUN apt-get update -y && apt-get install -y inotify-tools build-essential erlang-dev git curl \
  && apt-get clean && rm -f /var/lib/apt/lists/*_*

WORKDIR /app

RUN mix local.hex --force && \
  mix local.rebar --force

COPY . .
RUN mix deps.get

RUN mix compile

CMD ["mix", "test"]
