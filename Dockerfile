# syntax=docker/dockerfile:1

# Base image com Ruby 3.3.6
FROM ruby:3.3.5-slim

# Instala dependências do sistema
RUN apt-get update -qq && \
    apt-get install -y nodejs npm postgresql-client libpq-dev \
    ffmpeg libvips42 && \
    npm install -g yarn && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
# Define o diretório de trabalho
WORKDIR /app

# Instalar o ffmpeg
RUN apt-get update && apt-get install -y ffmpeg

# Copia o Gemfile e o Gemfile.lock para o diretório de trabalho
COPY Gemfile* ./

# Instala as gems
RUN bundle install

# Copia o restante do código do projeto
COPY . .

# Instala as dependências do JavaScript
RUN yarn install --frozen-lockfile


ENV PATH="/usr/local/bin:$PATH"

# Comando para iniciar o servidor Rails em desenvolvimento
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]