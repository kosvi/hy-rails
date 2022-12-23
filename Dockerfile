# FROM ruby:3.1.2-alpine
FROM ruby:3.1.2
# RUN apk add build-base postgresql-dev tzdata nodejs
RUN apt update && apt install -y nodejs
WORKDIR /usr/src/app
COPY . .
RUN bundle config set --local without 'development test'
RUN bundle install
RUN rails assets:precompile
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
