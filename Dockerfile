FROM buildkite/hosted-agent-base-images:ubuntu-jammy AS base

RUN apt-get update && apt-get install -y \
  git \
  jq \
  curl \
  autoconf \
  bison \
  build-essential \
  libssl-dev \
  libyaml-dev \
  libreadline6-dev \
  zlib1g-dev \
  libncurses5-dev \
  libffi-dev \
  libgdbm6 \
  libgdbm-dev \
  libdb-dev \
  libsqlite3-dev \
  pkg-config \
  && rm -rf /var/lib/apt/lists/*

RUN curl https://mise.run | sh
ENV PATH="/root/.local/share/mise/shims:/root/.local/bin:${PATH}"

FROM base AS runtime

WORKDIR /app
COPY .tool-versions ./
RUN mise install

COPY Gemfile Gemfile.lock ./
RUN mise exec -- bundle config set frozen true && mise exec -- bundle install

COPY . .
RUN mkdir -p storage tmp/pids

CMD ["bin/dev"]
